(define/contract (count-homogenous s)
  (-> string? exact-integer?)
  (define n (string-length s))
  (define (mod x) (modulo x 1000000007))
  (let loop ([i 0] [res 0] [current-char #f] [current-len 0])
    (cond
      [(= i n) (mod (+ res (quotient (* current-len (+ current-len 1)) 2)))]
      [else
       (define c (string-ref s i))
       (if (equal? c current-char)
           (loop (+ i 1) res c (+ current-len 1))
           (loop (+ i 1) 
                 (mod (+ res (quotient (* current-len (+ current-len 1)) 2))) 
                 c 
                 1))])))