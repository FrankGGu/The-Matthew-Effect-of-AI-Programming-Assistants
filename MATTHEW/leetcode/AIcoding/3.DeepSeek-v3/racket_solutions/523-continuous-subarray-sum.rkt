(define/contract (check-subarray-sum nums k)
  (-> (listof exact-integer?) exact-integer? boolean?)
  (let ([n (length nums)]
        [sums (make-hash)])
    (hash-set! sums 0 -1)
    (let loop ([i 0] [sum 0])
      (if (>= i n)
          #f
          (let* ([sum (+ sum (list-ref nums i))]
                 [rem (modulo sum k)]
                 [prev (hash-ref sums rem -2)])
            (if (>= prev -1)
                (if (> (- i prev) 1)
                    #t
                    (begin
                      (hash-set! sums rem i)
                      (loop (+ i 1) sum)))
                (begin
                  (hash-set! sums rem i)
                  (loop (+ i 1) sum))))))))