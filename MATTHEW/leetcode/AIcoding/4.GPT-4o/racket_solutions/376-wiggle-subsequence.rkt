(define (wiggleMaxLength nums)
  (define n (length nums))
  (if (<= n 1)
      n
      (define up 1)
      (define down 1)
      (for ([i (in-range 1 n)])
        (cond
          [(> (list-ref nums i) (list-ref nums (- i 1)))
           (set! up (add1 down))
           (set! down down)]
          [(< (list-ref nums i) (list-ref nums (- i 1)))
           (set! down (add1 up))
           (set! up up)])))
      (max up down)))

(define (wiggleMaxLengthWrapper nums)
  (wiggleMaxLength nums))