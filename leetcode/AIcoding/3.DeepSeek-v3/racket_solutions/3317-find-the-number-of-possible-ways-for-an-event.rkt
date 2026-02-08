#lang racket

(define (num-ways steps arrLen pos)
  (let* ([modulo (expt 10 9)]
         [max-pos (min (sub1 arrLen) steps)]
         [dp (make-vector (add1 steps) (make-hash))]
         [dfs (lambda (curr-step curr-pos memo)
                (if (= curr-step steps)
                    (if (zero? curr-pos) 1 0)
                    (let ([key curr-pos])
                      (if (hash-has-key? memo key)
                          (hash-ref memo key)
                          (let* ([stay (dfs (add1 curr-step) curr-pos (vector-ref dp (add1 curr-step)))]
                                 [left (if (positive? curr-pos)
                                          (dfs (add1 curr-step) (sub1 curr-pos) (vector-ref dp (add1 curr-step)))
                                          0)]
                                 [right (if (< curr-pos max-pos)
                                           (dfs (add1 curr-step) (add1 curr-pos) (vector-ref dp (add1 curr-step)))
                                           0)]
                                 [total (modulo (+ stay left right) modulo)])
                            (hash-set! memo key total)
                            total)))))])
    (dfs 0 0 (vector-ref dp 0))))