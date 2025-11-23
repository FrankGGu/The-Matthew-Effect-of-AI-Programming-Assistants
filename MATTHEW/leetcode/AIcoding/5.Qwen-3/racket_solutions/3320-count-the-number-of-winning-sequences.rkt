#lang racket

(define (count-winning-sequences)
  (define dp (make-hash))
  (define (dfs s i)
    (cond [(>= i 10) 1]
          [else
           (hash-ref dp (cons s i) #f)
           (let ([res 0])
             (for ([j (in-range 1 6)])
               (when (not (= j s))
                 (set! res (+ res (dfs j (+ i 1))))))
             (hash-set! dp (cons s i) res)
             res)]))
  (define (solve)
    (for/sum ([i (in-range 1 6)])
      (dfs i 0)))
  (solve))