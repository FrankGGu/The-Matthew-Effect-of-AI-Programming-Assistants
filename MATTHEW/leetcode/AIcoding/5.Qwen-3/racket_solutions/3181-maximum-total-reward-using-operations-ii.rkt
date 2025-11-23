#lang racket

(define (maximum-total-reward nums)
  (define sorted (sort nums <))
  (define memo (make-hash))
  (define (dfs i reward)
    (cond [(>= i (length sorted)) reward]
          [else
           (let ([key (cons i reward)])
             (if (hash-has-key? memo key)
                 (hash-ref memo key)
                 (let ([current (list-ref sorted i)])
                   (let ([option1 (if (<= current reward)
                                      (dfs (+ i 1) reward)
                                      (dfs (+ i 1) reward))]
                         [option2 (if (<= current reward)
                                      (dfs (+ i 1) (+ reward current))
                                      (dfs (+ i 1) reward))])
                     (let ([result (max option1 option2)])
                       (hash-set! memo key result)
                       result)))))]))
  (dfs 0 0))