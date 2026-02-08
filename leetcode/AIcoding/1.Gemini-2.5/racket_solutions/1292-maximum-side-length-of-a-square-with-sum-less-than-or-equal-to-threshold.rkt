(define (max-side-length grid threshold)
  (let* ((rows (length grid))
         (cols (if (null? grid) 0 (length (car grid)))))

    (when (or (= rows 0) (= cols 0))
      0)

    (let ((ps (make-vector (+ rows 1) (make-vector (+ cols 1) 0))))

      ;; Populate prefix sum array
      (for* ([r (in-range 1 (add1 rows))]
             [c (in-range 1 (add1 cols))])
        (let* ((grid-val (list-ref (list-ref grid (- r 1)) (- c 1)))
               (ps-r-c-1 (vector-ref (vector-ref ps r) (- c 1)))
               (ps-r-1-c (vector-ref (vector-ref ps (- r 1)) c))
               (ps-r-1-c-1 (vector-ref (vector-ref ps (- r 1)) (- c 1))))
          (vector-set! (vector-ref ps r) c
                       (+ grid-val ps-r-c-1 ps-r-1-c (- ps-r-1-c-1)))))

      ;; Iterate through possible square sizes k upwards
      ;; and find the maximum k for which at least one square satisfies the condition
      (let loop ((k 1) (current-max-k 0))
        (if (> k (min rows cols))
            current-max-k
            (let ((found-k-square
                   (for/first ([r (in-range k (add1 rows))]
                               [c (in-range k (add1 cols))])
                     (let* ((sum-val (+ (vector-ref (vector-ref ps r) c)
                                        (- (vector-ref (vector-ref ps (- r k)) c))
                                        (- (vector-ref (vector-ref ps r) (- c k)))
                                        (vector-ref (vector-ref ps (- r k)) (- c k)))))
                       (when (<= sum-val threshold)
                         #t)))))
              (loop (add1 k) (if found-k-square k current-max-k))))))))