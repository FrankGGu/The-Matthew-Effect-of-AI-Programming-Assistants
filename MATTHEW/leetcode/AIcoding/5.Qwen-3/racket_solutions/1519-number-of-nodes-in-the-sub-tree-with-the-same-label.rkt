#lang racket

(define (count-subtrees root)
  (define result (box '()))
  (define (dfs node)
    (if (not node)
        (vector 0 #f)
        (let* ([label (car node)]
               [children (cdr node)]
               [counts (make-vector 26 0)]
               [total 0])
          (for-each (lambda (child)
                      (let ([child-counts (dfs child)])
                        (for ([i (in-range 26)])
                          (vector-set! counts i (+ (vector-ref counts i) (vector-ref child-counts i))))
                        (set! total (+ total (vector-ref child-counts 0)))))
          (vector-set! counts label (+ 1 (vector-ref counts label)))
          (set-box! result (cons (vector-ref counts label) (unbox result)))
          (vector total #t))))
  (dfs root)
  (reverse (unbox result)))