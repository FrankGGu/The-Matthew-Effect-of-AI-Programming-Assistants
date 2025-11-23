(define (find-prime-pairs n)
  (define (prime? num)
    (if (<= num 1)
        #f
        (let loop ([i 2])
          (cond
            [(> (* i i) num) #t]
            [(zero? (modulo num i)) #f]
            [else (loop (+ i 1))]))))

  (define result '())
  (for ([i (in-range 2 (add1 (quotient n 2)))])
    (when (and (prime? i) (prime? (- n i)))
      (set! result (cons (list i (- n i)) result))))
  (reverse result))