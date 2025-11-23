(define (find-array-given-subset-sums sums)
  (let* ([n (inexact->exact (round (/ (log (length sums)) (log 2))))]
         [result (make-vector n)])
    (let loop ([k 0] [current-sums (sort sums <)])
      (when (< k n)
        (let* ([x (- (list-ref current-sums 1) (list-ref current-sums 0))])
          ;; Try to form next-sums with x
          (let* ([freq-map-x (make-hash)]
                 [next-sums-x (list)]
                 [possible-x #t])
            (for-each (lambda (s) (hash-set! freq-map-x s (+ (hash-ref freq-map-x s 0) 1))) current-sums)

            (for-each (lambda (s)
                        (when (and possible-x (> (hash-ref freq-map-x s 0) 0))
                          (hash-set! freq-map-x s (- (hash-ref freq-map-x s) 1))
                          (let ([s-plus-x (+ s x)])
                            (if (> (hash-ref freq-map-x s-plus-x 0) 0)
                                (begin
                                  (hash-set! freq-map-x s-plus-x (- (hash-ref freq-map-x s-plus-x) 1))
                                  (set! next-sums-x (cons s next-sums-x)))
                                (set! possible-x #f)))))
                      current-sums)

            (if possible-x
                (begin
                  (vector-set! result k x)
                  (loop (+ k 1) (sort (reverse next-sums-x) <)))
                ;; If x didn't work, try -x
                (let* ([neg-x (- x)]
                       [freq-map-neg-x (make-hash)]
                       [next-sums-neg-x (list)]
                       [possible-neg-x #t])
                  (for-each (lambda (s) (hash-set! freq-map-neg-x s (+ (hash-ref freq-map-neg-x s 0) 1))) current-sums)

                  (for-each (lambda (s)
                              (when (and possible-neg-x (> (hash-ref freq-map-neg-x s 0) 0))
                                (hash-set! freq-map-neg-x s (- (hash-ref freq-map-neg-x s) 1))
                                (let ([s-plus-neg-x (+ s neg-x)])
                                  (if (> (hash-ref freq-map-neg-x s-plus-neg-x 0) 0)
                                      (begin
                                        (hash-set! freq-map-neg-x s-plus-neg-x (- (hash-ref freq-map-neg-x s-plus-neg-x) 1))
                                        (set! next-sums-neg-x (cons s next-sums-neg-x)))
                                      (set! possible-neg-x #f)))))
                            current-sums)

                  (if possible-neg-x
                      (begin
                        (vector-set! result k neg-x)
                        (loop (+ k 1) (sort (reverse next-sums-neg-x) <)))
                      ;; This case should not happen based on problem constraints
                      (error "Neither x nor -x worked.")))))))
    (vector->list result)))