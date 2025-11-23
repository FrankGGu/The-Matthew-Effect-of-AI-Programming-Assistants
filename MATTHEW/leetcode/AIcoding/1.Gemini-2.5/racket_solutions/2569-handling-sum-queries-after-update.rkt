(define (handle-sum-queries nums1 nums2 queries)
  (define n (vector-length nums1))
  (define tree (make-vector (* 4 n))) ; Stores (vector sum-one sum-zero lazy-flip)

  ; Helper to get/set node properties
  (define (node-sum-one idx) (vector-ref (vector-ref tree idx) 0))
  (define (node-sum-zero idx) (vector-ref (vector-ref tree idx) 1))
  (define (node-lazy idx) (vector-ref (vector-ref tree idx) 2))
  (define (set-node-sum-one! idx val) (vector-set! (vector-ref tree idx) 0 val))
  (define (set-node-sum-zero! idx val) (vector-set! (vector-ref tree idx) 1 val))
  (define (set-node-lazy! idx val) (vector-set! (vector-ref tree idx) 2 val))

  ; Apply flip to a node (swaps sum-one and sum-zero, toggles lazy flag)
  (define (apply-flip! idx)
    (let ([current-sum-one (node-sum-one idx)]
          [current-sum-zero (node-sum-zero idx)])
      (set-node-sum-one! idx current-sum-zero)
      (set-node-sum-zero! idx current-sum-one)
      (set-node-lazy! idx (not (node-lazy idx)))))

  ; Push down lazy flag from current node to its children
  (define (push-down! idx)
    (when (node-lazy idx)
      (apply-flip! (+ (* 2 idx) 1)) ; Left child
      (apply-flip! (+ (* 2 idx) 2)) ; Right child
      (set-node-lazy! idx #f)))

  ; Pull up sums from children to current node
  (define (pull-up! idx)
    (set-node-sum-one! idx (+ (node-sum-one (+ (* 2 idx) 1)) (node-sum-one (+ (* 2 idx) 2))))
    (set-node-sum-zero! idx (+ (node-sum-zero (+ (* 2 idx) 1)) (node-sum-zero (+ (* 2 idx) 2)))))

  ; Build segment tree
  (define (build! idx seg-l seg-r)
    (if (= seg-l seg-r)
        (begin ; Leaf node
          (vector-set! tree idx (vector 0 0 #f)) ; Initialize node
          (if (= (vector-ref nums1 seg-l) 1)
              (set-node-sum-one! idx (vector-ref nums2 seg-l))
              (set-node-sum-zero! idx (vector-ref nums2 seg-l))))
        (let ([mid (quotient (+ seg-l seg-r) 2)])
          (build! (+ (* 2 idx) 1) seg-l mid)
          (build! (+ (* 2 idx) 2) (+ mid 1) seg-r)
          (vector-set! tree idx (vector 0 0 #f)) ; Initialize node
          (pull-up! idx))))

  ; Point update (Type 0: [0, target-idx, new-val])
  (define (update-point! idx seg-l seg-r target-idx new-val)
    (push-down! idx) ; Push down lazy flag before potentially reaching leaf
    (if (= seg-l seg-r)
        (begin ; Leaf node
          (if (= new-val 1)
              (begin
                (set-node-sum-one! idx (vector-ref nums2 target-idx))
                (set-node-sum-zero! idx 0))
              (begin
                (set-node-sum-one! idx 0)
                (set-node-sum-zero! idx (vector-ref nums2 target-idx))))
          ; Update nums1 vector as well
          (vector-set! nums1 target-idx new-val))
        (let ([mid (quotient (+ seg-l seg-r) 2)])
          (if (<= target-idx mid)
              (update-point! (+ (* 2 idx) 1) seg-l mid target-idx new-val)
              (update-point! (+ (* 2 idx) 2) (+ mid 1) seg-r target-idx new-val))
          (pull-up! idx))))

  ; Range flip (Type 1: [1, query-l, query-r])
  (define (update-range-flip! idx seg-l seg-r query-l query-r)
    (if (and (<= query-l seg-l) (>= query-r seg-r)) ; Current segment fully within query range
        (apply-flip! idx)
        (begin
          (push-down! idx)
          (let ([mid (quotient (+ seg-l seg-r) 2)])
            (when (<= query-l mid)
              (update-range-flip! (+ (* 2 idx) 1) seg-l mid query-l query-r))
            (when (>= query-r (+ mid 1))
              (update-range-flip! (+ (* 2 idx) 2) (+ mid 1) seg-r query-l query-r)))
          (pull-up! idx))))

  ; Range sum (Type 2: [2, query-l, query-r])
  (define (query-range-sum! idx seg-l seg-r query-l query-r)
    (if (and (<= query-l seg-l) (>= query-r seg-r)) ; Current segment fully within query range
        (node-sum-one idx) ; We need sum of nums2[i] where nums1[i] is 1
        (begin
          (push-down! idx)
          (let ([mid (quotient (+ seg-l seg-r) 2)])
            (let ([left-sum (if (<= query-l mid)
                                (query-range-sum! (+ (* 2 idx) 1) seg-l mid query-l query-r)
                                0)]
                  [right-sum (if (>= query-r (+ mid 1))
                                 (query-range-sum! (+ (* 2 idx) 2) (+ mid 1) seg-r query-l query-r)
                                 0)])
              (+ left-sum right-sum))))))

  ; Initialize the segment tree
  (build! 0 0 (- n 1))

  ; Process queries
  (define results '())
  (for-each (lambda (query)
              (let ([type (car query)])
                (cond
                  [(= type 0) ; [0, idx, val]
                   (let ([idx (cadr query)]
                         [val (caddr query)])
                     (update-point! 0 0 (- n 1) idx val))]
                  [(= type 1) ; [1, l, r]
                   (let ([l (cadr query)]
                         [r (caddr query)])
                     (update-range-flip! 0 0 (- n 1) l r))]
                  [(= type 2) ; [2, l, r]
                   (let ([l (cadr query)]
                         [r (caddr query)])
                     (set! results (cons (query-range-sum! 0 0 (- n 1) l r) results)))])))
            queries)
  (reverse results))