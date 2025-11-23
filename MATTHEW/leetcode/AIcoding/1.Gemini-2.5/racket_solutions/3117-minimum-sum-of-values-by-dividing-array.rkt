#lang racket

(define-const +infinity.0 (expt 10 18))

(struct line (m c))

(define (make-li-chao-tree unique-and-vals)
  (let* ((num-coords (length unique-and-vals))
         (tree (make-vector (* 4 num-coords) #f)))

    (define (get-val line x-idx)
      (if line
          (let ((actual-x (list-ref unique-and-vals x-idx)))
            (+ (* (line-m line) actual-x) (line-c line)))
          +infinity.0))

    (define (add-line-node node-idx x-low-idx x-high-idx new-line)
      (when (> x-low-idx x-high-idx) (error "Invalid range"))
      (let ((curr-line (vector-ref tree node-idx)))
        (when (not curr-line)
          (vector-set! tree node-idx new-line)
          (void))
        (when curr-line
          (let* ((mid-idx (quotient (+ x-low-idx x-high-idx) 2))
                 (val-curr-low (get-val curr-line x-low-idx))
                 (val-new-low (get-val new-line x-low-idx))
                 (val-curr-mid (get-val curr-line mid-idx))
                 (val-new-mid (get-val new-line mid-idx)))
            (cond
              ((and (<= val-new-low val-curr-low) (<= val-new-mid val-curr-mid))
               (vector-set! tree node-idx new-line))
              ((and (<= val-curr-low val-new-low) (<= val-curr-mid val-new-mid))
               (void))
              (else
               (let ((swap? (<= val-new-low val-curr-low)))
                 (when swap?
                   (let ((temp curr-line))
                     (set! curr-line new-line)
                     (set! new-line temp)
                     (vector-set! tree node-idx curr-line)))
                 (if (< val-new-mid val-curr-mid)
                     (add-line-node (* 2 node-idx 1) (+ mid-idx 1) x-high-idx new-line)
                     (add-line-node (* 2 node-idx 0) x-low-idx mid-idx new-line))))))))))

    (define (query-node node-idx x-low-idx x-high-idx query-x-idx)
      (when (> x-low-idx x-high-idx) (error "Invalid range"))
      (let ((curr-line (vector-ref tree node-idx)))
        (let ((res (get-val curr-line query-x-idx)))
          (cond
            ((= x-low-idx x-high-idx) res)
            (else
             (let ((mid-idx (quotient (+ x-low-idx x-high-idx) 2)))
               (min res
                    (if (<= query-x-idx mid-idx)
                        (query-node (* 2 node-idx 0) x-low-idx mid-idx query-x-idx)
                        (query-node (* 2 node-idx 1) (+ mid-idx 1) x-high-idx query-x-idx)))))))))

    (list add-line-node query-node)))

(define (make-segment-tree-of-li-chao-trees N unique-and-vals)
  (let* ((num-unique-and-vals (length unique-and-vals))
         (seg-tree (make-vector (* 4 (+ N 1)) #f)))

    (define (build-seg-tree node-idx p-low p-high)
      (vector-set! seg-tree node-idx (make-li-chao-tree unique-and-vals))
      (when (< p-low p-high)
        (let ((mid (quotient (+ p-low p-high) 2)))
          (build-seg-tree (* 2 node-idx 0) p-low mid)
          (build-seg-tree (* 2 node-idx 1) (+ mid 1) p-high))))

    (build-seg-tree 1 0 N)

    (define (add-line-seg-tree node-idx p-low p-high target-p m c)
      (let ((add-lch-line (car (vector-ref seg-tree node-idx))))
        (add-lch-line 1 0 (- num-unique-and-vals 1) (line m c)))
      (when (< p-low p-high)
        (let ((mid (quotient (+ p-low p-high) 2)))
          (if (<= target-p mid)
              (add-line-seg-tree (* 2 node-idx 0) p-low mid target-p m c)
              (add-line-seg-tree (* 2 node-idx 1) (+ mid 1) p-high target-p m c)))))

    (define (query-seg-tree node-idx p-low p-high query-p-low query-p-high query-x-idx)
      (cond
        ((or (> p-low query-p-high) (< p-high query-p-low)) +infinity.0)
        ((and (>= p-low query-p-low) (<= p-high query-p-high))
         (let ((query-lch (cdr (vector-ref seg-tree node-idx))))
           (query-lch 1 0 (- num-unique-and-vals 1) query-x-idx)))
        (else
         (let ((mid (quotient (+ p-low p-high) 2)))
           (min (query-seg-tree (* 2 node-idx 0) p-low mid query-p-low query-p-high query-x-idx)
                (query-seg-tree (* 2 node-idx 1) (+ mid 1) p-high query-p-low query-p-high query-x-idx))))))

    (list add-line-seg-tree query-seg-tree)))

(define (minimum-sum-of-values-by-dividing-array nums andValues k)
  (let* ((N (vector-length nums))
         (dp-prev (make-vector N +infinity.0))
         (dp-curr (make-vector N +infinity.0)))

    (define P_min (make-vector N 0))
    (define P_max (make-vector N 0))

    (let ((stack '()))
      (for ([i (in-range N)])
        (let ((target-val (vector-ref andValues i)))
          (set! stack (drop-while stack (lambda (idx) (>= (vector-ref nums idx) target-val))))
          (vector-set! P_min i (if (empty? stack) 0 (+ (car stack) 1))))
        (set! stack (cons i stack))))

    (let ((last-pos (make-hash)))
      (for ([i (in-range N)])
        (hash-set! last-pos (vector-ref nums i) i)
        (let ((target-val (vector-ref andValues i)))
          (vector-set! P_max i (hash-ref last-pos target-val -1)))))

    (let* ((all-and-vals (make-vector N))
           (_ (for ([i (in-range N)]) (vector-set! all-and-vals i (vector-ref andValues i))))
           (unique-and-vals (sort (remove-duplicates (vector->list all-and-vals)) <))
           (unique-and-vals-map (make-hash)))
      (for ([i (in-range (length unique-and-vals))])
        (hash-set! unique-and-vals-map (list-ref unique-and-vals i) i))

      (for ([j (in-range 1 (+ k 1))])
        (let-values (((add-line-seg-tree query-seg-tree)
                      (make-segment-tree-of-li-chao-trees N unique-and-vals)))

          (let ((c-for-p-0 (if (= j 1) 0 +infinity.0)))
            (add-line-seg-tree 1 0 N 0 0 c-for-p-0))

          (for ([p-val (in-range 1 (+ N 1))])
            (let ((c-val (vector-ref dp-prev (- p-val 1))))
              (when (< c-val +infinity.0)
                (add-line-seg-tree 1 0 N p-val (- p-val) c-val))))

          (for ([i (in-range N)])
            (let* ((target-and-val (vector-ref andValues i))
                   (compressed-target-and-val (hash-ref unique-and-vals-map target-and-val)))
              (let ((p-min-val (vector-ref P_min i))
                    (p-max-val (vector-ref P_max i)))
                (when (and (<= p-min-val p-max-val) (>= p-min-val 0) (<= p-max-val N))
                  (let ((min-val-from-query
                         (query-seg-tree 1 0 N p-min-val p-max-val compressed-target-and-val)))
                    (when (< min-val-from-query +infinity.0)
                      (vector-set! dp-curr i
                                   (+ (* (+ i 1) target-and-val) min-val-from-query)))))))

          (vector-copy! dp-prev dp-curr)
          (vector-fill! dp-curr +infinity.0)))

    (let ((ans (vector-ref dp-prev (- N 1))))
      (if (= ans +infinity.0) -1 ans))))