#lang racket

(define (minReorder n connections)
  (define graph (make-vector n '()))
  (for ([conn connections])
    (let ([u (first conn)]
          [v (second conn)])
      (vector-set! graph u (cons (list v #t) (vector-ref graph u)))
      (vector-set! graph v (cons (list u #f) (vector-ref graph v)))))

  (define (dfs city visited)
    (set! visited (cons city visited))
    (foldl (lambda (neighbor acc)
              (if (member (first neighbor) visited)
                  acc
                  (+ (if (second neighbor) 1 0) (dfs (first neighbor) visited))))
            0
            (vector-ref graph city)))

  (dfs 0 '()))