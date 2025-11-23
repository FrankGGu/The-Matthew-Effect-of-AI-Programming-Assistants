(define (count-stable-arrays n k)
  (define memo (make-hash))

  (define (dp len ones last-bit)
    (cond
      [(and (= len n) (= ones k)) 1]
      [(or (> len n) (> ones k)) 0]
      [else
       (let ([key (list len ones last-bit)])
         (if (hash-has-key? memo key)
             (hash-ref memo key)
             (let ([result (cond
                             [(= last-bit 0)
                              (+ (dp (+ len 1) ones 0)
                                 (dp (+ len 1) (+ ones 1) 1))]
                             [else
                              (+ (dp (+ len 1) ones 0)
                                 (dp (+ len 1) (+ ones 1) 1))])])
               (hash-set! memo key result)
               result))))]))

  (+ (dp 1 0 0) (dp 1 1 1)))