(define (max-sum-with-k-elements nums k)
  (define (helper lst k)
    (if (zero? k)
        0
        (+ (apply max lst) (helper (filter (lambda (x) (not (= x (apply max lst)))) lst) (- k 1)))))
  (helper nums k))

(define (maximumSum nums k)
  (max-sum-with-k-elements nums k))