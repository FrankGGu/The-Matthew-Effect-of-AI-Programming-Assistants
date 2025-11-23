#lang racket

(define (manhattan-distances n)
  (define (dfs path visited)
    (if (= (length path) n)
        (let ([res (map (lambda (i) (abs (- (list-ref path i) (add1 i)))) (range n))])
          (list res))
        (apply append
               (for/list ([i (in-range n)]
                          #:when (not (member i visited)))
                 (dfs (append path (list i)) (append visited (list i)))))))
  (define (solve)
    (let ([all (dfs '() '())])
      (for/list ([d all])
        (apply + d))))
  (solve))