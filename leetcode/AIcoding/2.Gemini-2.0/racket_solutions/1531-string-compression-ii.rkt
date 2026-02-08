(define (string-compression-ii s k)
  (define n (string-length s))
  (define memo (make-hash))

  (define (dp i remaining)
    (cond
      [(<= remaining 0) (if (= i n) 0 #f)]
      [(= i n) 0]
      [(hash-ref memo (cons i remaining) #f) => (λ (val) val)]
      [else
       (let loop ([j i] [count 0] [deleted 0] [best #f])
         (cond
           [(> j n) best]
           [else
            (let ([curr (string-ref s i)]
                  [new-count (if (char=? curr (string-ref s j)) (+ count 1) 0)])
              (cond
                [(= new-count 0)
                 (let ([res (dp j remaining)])
                   (cond
                     [(and res (not best)) (loop (+ j 1) 0 (+ deleted 1) res)]
                     [(and res best) (loop (+ j 1) 0 (+ deleted 1) (min best res))]
                     [else (loop (+ j 1) 0 (+ deleted 1) best)]))]
                [else
                 (let ([res (dp (+ j 1) remaining)])
                   (define cost (cond
                                 [(= new-count 1) 1]
                                 [(<= new-count 9) 2]
                                 [(<= new-count 99) 3]
                                 [else 4]))
                   (define new-best (if (= j (- i 1)) #f (if res (+ cost (dp (+ j 1) remaining)) #f)))
                   (let ([res-del (if (>= remaining 1) (dp (+ j 1) (- remaining 1)) #f)])
                     (cond
                       [(and new-best (not best)) (loop (+ j 1) new-count deleted new-best)]
                       [(and new-best best) (loop (+ j 1) new-count deleted (min best new-best))]
                       [(and res-del (>= remaining 1))
                        (cond
                          [(and res-del (not best)) (loop (+ j 1) new-count (+ deleted 1) res-del)]
                          [(and res-del best) (loop (+ j 1) new-count (+ deleted 1) (min best res-del))]
                          [else (loop (+ j 1) new-count (+ deleted 1) best)])]
                       [else (loop (+ j 1) new-count deleted best)]))])))])))]))
       (let ([result (dp i k)])
         (if result
             (begin (hash-set! memo (cons i k) result) result)
             #f)))]))

  (let ([result (dp 0 k)])
    (if result result 1000000000)))