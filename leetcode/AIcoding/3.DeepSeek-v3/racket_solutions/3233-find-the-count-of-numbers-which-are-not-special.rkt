(define/contract (count-special-numbers n)
  (-> exact-integer? exact-integer?)
  (define (is-special? num)
    (let loop ([n num] [digits (set)])
      (if (zero? n)
          #t
          (let ([d (modulo n 10)])
            (if (set-member? digits d)
                #f
                (loop (quotient n 10) (set-add digits d))))))
  (let loop ([i 1] [count 0])
    (if (> i n)
        count
        (loop (+ i 1) (if (is-special? i) count (+ count 1))))))