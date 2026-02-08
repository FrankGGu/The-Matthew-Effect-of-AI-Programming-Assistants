(define/contract (preimage-size-fzf k)
  (-> exact-integer? exact-integer?)
  (define (count-zeros n)
    (let loop ([n n] [count 0])
      (if (zero? n) count (loop (quotient n 5) (+ count n)))))
  (define (binary-search)
    (let loop ([low 0] [high (* 5 (add1 k))])
      (if (> low high) 0
          (let* ([mid (quotient (+ low high) 2)]
                 [zeros (count-zeros mid)])
            (cond
              [(= zeros k) 5]
              [(< zeros k) (loop (add1 mid) high)]
              [else (loop low (sub1 mid))])))))
  (binary-search))