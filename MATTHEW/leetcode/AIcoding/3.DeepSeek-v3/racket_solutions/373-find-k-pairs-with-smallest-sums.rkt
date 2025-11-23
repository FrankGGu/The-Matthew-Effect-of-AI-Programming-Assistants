(define (k-smallest-pairs nums1 nums2 k)
  (let* ((len1 (length nums1))
         (len2 (length nums2))
         (heap (make-heap (lambda (a b) (< (+ (car a) (cadr a)) (+ (car b) (cadr b))))))))
    (when (and (> len1 0) (> len2 0))
      (for ([i (in-range (min len1 k))])
        (heap-add! heap (list (list-ref nums1 i) (list-ref nums2 0) i 0))))
    (let loop ([res '()])
      (if (or (heap-empty? heap) (>= (length res) k))
          (reverse res)
          (let* ([top (heap-remove! heap)]
                 [x (car top)]
                 [y (cadr top)]
                 [i (caddr top)]
                 [j (cadddr top)]
                 [new-j (+ j 1)])
            (when (< new-j len2)
              (heap-add! heap (list x (list-ref nums2 new-j) i new-j)))
            (loop (cons (list x y) res))))))

(define (make-heap cmp)
  (let ([heap '()])
    (define (heap-add! x)
      (set! heap (cons x heap))
      (heapify-up! (- (length heap) 1)))
    (define (heap-remove!)
      (if (null? heap)
          #f
          (let ([top (car heap)])
            (set! heap (append (cdr heap) (list (last heap))))
            (set! heap (take heap (- (length heap) 1)))
            (heapify-down! 0)
            top)))
    (define (heap-empty?)
      (null? heap))
    (define (heapify-up! idx)
      (let ([parent (quotient (- idx 1) 2)])
        (when (and (>= parent 0) (cmp (list-ref heap idx) (list-ref heap parent)))
          (let ([tmp (list-ref heap parent)])
            (list-set! heap parent (list-ref heap idx))
            (list-set! heap idx tmp)
            (heapify-up! parent)))))
    (define (heapify-down! idx)
      (let* ([left (+ (* idx 2) 1)]
             [right (+ (* idx 2) 2)]
             [smallest idx])
        (when (and (< left (length heap)) (cmp (list-ref heap left) (list-ref heap smallest)))
          (set! smallest left))
        (when (and (< right (length heap)) (cmp (list-ref heap right) (list-ref heap smallest)))
          (set! smallest right))
        (when (not (= smallest idx))
          (let ([tmp (list-ref heap idx)])
            (list-set! heap idx (list-ref heap smallest))
            (list-set! heap smallest tmp)
            (heapify-down! smallest)))))
    (lambda (msg . args)
      (case msg
        ['add! (apply heap-add! args)]
        ['remove! (heap-remove!)]
        ['empty? (heap-empty?)]))))

(define (heap-add! heap x) ((heap 'add!) x))
(define (heap-remove! heap) ((heap 'remove!)))
(define (heap-empty? heap) ((heap 'empty?)))