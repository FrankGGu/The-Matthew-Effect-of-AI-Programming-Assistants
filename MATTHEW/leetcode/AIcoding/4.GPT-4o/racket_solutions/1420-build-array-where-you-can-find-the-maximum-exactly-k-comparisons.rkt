(define (maxArray k)
  (define (helper n k)
    (if (zero? k)
        (list n)
        (cons n (append (helper (- n 1) (- k 1)) (helper n (- k 1))))))
  (helper 100 k))

(define (buildArray k)
  (if (= k 0)
      (list 1)
      (maxArray k)))

(buildArray 2)