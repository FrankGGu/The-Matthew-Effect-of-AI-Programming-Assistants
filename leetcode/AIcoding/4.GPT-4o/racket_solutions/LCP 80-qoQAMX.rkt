(define (evolution n)
  (define (helper n)
    (if (zero? n)
        1
        (+ (helper (sub1 n)) (helper (sub1 (sub1 n))))))
  (helper n))

(evolution n)