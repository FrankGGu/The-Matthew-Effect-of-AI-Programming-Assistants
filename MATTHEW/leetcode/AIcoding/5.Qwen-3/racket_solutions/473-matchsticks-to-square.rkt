#lang racket

(define (can-construct-square matchsticks)
  (let* ((total (apply + matchsticks))
         (n (length matchsticks))
         (side (quotient total 4)))
    (if (or (not (zero? (modulo total 4))) (null? matchsticks))
        #f
        (let ((visited (make-vector n #f)))
          (define (dfs index target)
            (cond ((= target 0) #t)
                  ((= index n) #f)
                  (else
                   (if (vector-ref visited index)
                       (dfs (+ index 1) target)
                       (begin
                         (vector-set! visited index #t)
                         (if (dfs index (- target (list-ref matchsticks index)))
                             #t
                             (begin
                               (vector-set! visited index #f)
                               (dfs (+ index 1) target))))))))
          (dfs 0 side)))))