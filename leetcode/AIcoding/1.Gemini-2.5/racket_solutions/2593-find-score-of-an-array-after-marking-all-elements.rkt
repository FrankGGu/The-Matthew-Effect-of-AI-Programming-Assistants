#lang racket

(define (find-score-of-array nums)
  (let* ([n (length nums)]
         [indexed-nums (for/list ([val (in-list nums)]
                                  [idx (in-range n)])
                         (cons val idx))]
         [sorted-indexed-nums (sort indexed-nums (lambda (a b) (< (car a) (car b))))]
         [marked (make-vector n #f)]
         [score 0])

    (for-each (lambda (pair)
                (let* ([val (car pair)]
                       [idx (cdr pair)])
                  (unless (vector-ref marked idx)
                    (set! score (+ score val))
                    (vector-set! marked idx #t)
                    (when (> idx 0)
                      (vector-set! marked (- idx 1) #t))
                    (when (< idx (- n 1))
                      (vector-set! marked (+ idx 1) #t)))))
              sorted-indexed-nums)
    score))