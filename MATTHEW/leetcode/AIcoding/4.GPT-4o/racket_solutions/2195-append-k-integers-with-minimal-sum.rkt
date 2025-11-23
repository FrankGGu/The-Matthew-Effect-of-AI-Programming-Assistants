(define (minimalKSum nums k)
  (define unique-nums (remove-duplicates (sort nums <)))
  (define n (length unique-nums))
  (define (helper m k sum)
    (if (zero? k)
        sum
        (if (member m unique-nums)
            (helper (+ m 1) k sum)
            (helper (+ m 1) (- k 1) (+ sum m)))))
  (helper 1 k 0))

(minimalKSum '(1 4 6 5) 3)