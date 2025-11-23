(define/contract (delete-and-earn nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([max-num (apply max nums)]
         [counts (make-vector (add1 max-num) 0)])
    (for ([num nums])
      (vector-set! counts num (+ (vector-ref counts num) num)))
    (let loop ([i 0] [prev 0] [curr 0])
      (if (> i max-num)
          curr
          (let ([temp curr])
            (loop (add1 i)
                  temp
                  (max (+ prev (vector-ref counts i)) curr)))))))