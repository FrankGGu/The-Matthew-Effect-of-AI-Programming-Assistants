#lang racket

(define (shortest-path tree)
  (define (dfs node parent dist)
    (if (null? node)
        0
        (let ((current (car node)))
          (if (equal? current '())
              0
              (let ((left (cadr node))
                    (right (caddr node)))
                (let ((left-dist (if (null? left) 0 (dfs left current (+ dist (cadr current)))))
                      (right-dist (if (null? right) 0 (dfs right current (+ dist (caddr current)))))
                      (current-dist (if (null? parent) 0 (if (equal? parent '()) 0 (abs (- (car current) (car parent))))))
                (min left-dist right-dist current-dist)))))))
  (dfs tree '() 0))