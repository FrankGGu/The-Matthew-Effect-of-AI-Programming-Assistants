(define (split-with-minimum-sum num)
  (define (extract-digits n)
    (let loop ((n n) (acc '()))
      (if (= n 0)
          acc
          (loop (quotient n 10) (cons (remainder n 10) acc)))))

  (define sorted-digits (sort (extract-digits num) <))

  (define d0 (list-ref sorted-digits 0))
  (define d1 (list-ref sorted-digits 1))
  (define d2 (list-ref sorted-digits 2))
  (define d3 (list-ref sorted-digits 3))

  (define new1 (+ (* d0 10) d2))
  (define new2 (+ (* d1 10) d3))

  (+ new1 new2))