(define (finalArray nums k)
  (define (apply-multiplications arr k)
    (if (zero? k)
        arr
        (apply-multiplications (map (lambda (x) (* x 2)) arr) (sub1 k))))
  (apply-multiplications nums k))

(finalArray '(1 2 3 4) 2)