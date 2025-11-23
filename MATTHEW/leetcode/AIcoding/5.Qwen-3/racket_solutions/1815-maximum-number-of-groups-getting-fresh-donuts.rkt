#lang racket

(define (max-groups-getting-fresh-donuts batchSize ands)
  (define (dfs idx cnt)
    (cond [(= idx (vector-length ands)) cnt]
          [else
           (let ([a (vector-ref ands idx)])
             (if (= a 0)
                 (dfs (add1 idx) cnt)
                 (let loop ([i 0] [res 0])
                   (if (= i (add1 cnt))
                       res
                       (let ([new-cnt (+ cnt (if (= (modulo a (add1 i)) 0) 1 0))])
                         (loop (add1 i) (max res (dfs (add1 idx) new-cnt)))))))])))
  (dfs 0 0))