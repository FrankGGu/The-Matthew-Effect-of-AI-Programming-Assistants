(define (minimum-index valid-split)
  (define n (length valid-split))
  (define (valid-split? i)
    (and (>= i 0) (< i n) (equal? (list-ref valid-split i) 1)))
  (define (find-index i)
    (if (>= i n)
        -1
        (if (valid-split? i)
            i
            (find-index (+ i 1)))))
  (find-index 0))

(minimum-index '(0 1 0 1 0))