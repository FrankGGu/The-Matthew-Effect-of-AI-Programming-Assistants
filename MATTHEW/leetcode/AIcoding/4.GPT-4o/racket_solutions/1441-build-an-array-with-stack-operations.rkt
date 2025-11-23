(define (buildArray target n)
  (define stack '())
  (define result '())
  (for ([i (in-range 1 (+ n 1))])
    (if (and (<= i (length target)) (= i (list-ref target (- i 1))))
        (begin
          (set! stack (cons 'Push stack))
          (set! result (cons "Push" result)))
        (begin
          (set! stack (cons 'Push stack))
          (set! result (cons "Push" result))
          (set! stack (cons 'Pop stack))
          (set! result (cons "Pop" result)))))
  (reverse result))

(buildArray '(1 3) 3)