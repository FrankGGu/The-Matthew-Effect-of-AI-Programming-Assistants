(define (min-impossible-or A)
  (define (bitmask A)
    (foldl (lambda (x acc) (bitwise-or acc x)) 0 A))
  (define bm (bitmask A))
  (define (find-minimum x)
    (if (zero? (bitwise-and bm x))
        x
        (find-minimum (add1 x))))
  (find-minimum 1))

(min-impossible-or '(1 2 3))