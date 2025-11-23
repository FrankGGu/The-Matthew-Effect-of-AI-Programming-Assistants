(define (count-digits num)
  (let loop ([n (abs num)] [count 0])
    (if (= n 0)
        count
        (let ([d (modulo n 10)])
          (if (and (> d 0) (= (modulo num d) 0))
              (loop (quotient n 10) (+ count 1))
              (loop (quotient n 10) count))))))