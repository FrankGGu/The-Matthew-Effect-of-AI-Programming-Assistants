(define (count-arrays n k x)
  (define memo (make-hash))

  (define (solve i j l)
    (cond
      [(= i n) (if (= j k) 1 0)]
      [(hash-ref memo (list i j l) #f) => (λ (v) v)]
      [else
       (let loop ([m 1] [res 0])
         (if (> m x)
             (begin
               (hash-set! memo (list i j l) res)
               res)
             (let ([new-j (if (= l m) j (+ j 1))])
               (if (<= new-j k)
                   (loop (+ m 1) (+ res (solve (+ i 1) new-j m)))
                   (loop (+ m 1) res)))))]))

  (solve 1 0 0))