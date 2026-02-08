(define (num-of-arrays n m k)
  (define memo (make-hash))

  (define (dp len max-val remaining-cost)
    (cond
      [(and (= len n) (= remaining-cost 0)) 1]
      [(or (= len n) (= remaining-cost 0)) 0]
      [(<= remaining-cost 0) 0]
      [(>= len n) 0]
      [(hash-ref memo (list len max-val remaining-cost) #f)
       (hash-ref memo (list len max-val remaining-cost))]
      [else
       (let* ([res (modulo (foldl (lambda (i acc)
                                      (modulo (+ acc (if (> i max-val) (dp (+ len 1) i (- remaining-cost 1)) (dp (+ len 1) max-val remaining-cost))) 1000000007))
                                  0
                                  (range 1 (+ m 1)))
                         1000000007)])
         (hash-set! memo (list len max-val remaining-cost) res)
         res)]))

  (dp 0 0 k))