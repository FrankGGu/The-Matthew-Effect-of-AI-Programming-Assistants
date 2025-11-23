(define (read-binary-watch turned-on)
  (define (count-bits n)
    (let loop ([n n] [count 0])
      (if (= n 0)
          count
          (loop (bitwise-and n (- n 1)) (+ count 1)))))

  (define (valid-time? hours minutes)
    (and (<= hours 11) (<= minutes 59)))

  (define result '())
  (for ([hours (in-range 0 12)])
    (for ([minutes (in-range 0 60)])
      (if (= (+ (count-bits hours) (count-bits minutes)) turned-on)
          (set! result (cons (format "~a:~a" hours (if (< minutes 10) (format "0~a" minutes) minutes)) result)))))
  result)