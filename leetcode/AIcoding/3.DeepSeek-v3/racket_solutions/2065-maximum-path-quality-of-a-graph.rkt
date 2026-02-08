#lang racket

(define (maximal-path-quality values edges maxTime)
  (define graph (make-hash))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)]
          [time (third edge)])
      (hash-update! graph u (lambda (lst) (cons (list v time) lst)) '())
      (hash-update! graph v (lambda (lst) (cons (list u time) lst)) '())))

  (define max-quality 0)
  (define visited (make-hash))
  (hash-set! visited 0 1)

  (define (dfs node current-time current-quality)
    (when (<= current-time maxTime)
      (when (= node 0)
        (set! max-quality (max max-quality current-quality)))
      (for ([neighbor (hash-ref graph node '())])
        (let ([next-node (first neighbor)]
              [time (second neighbor)])
          (if (hash-has-key? visited next-node)
              (dfs next-node (+ current-time time) current-quality)
              (begin
                (hash-update! visited next-node add1 0)
                (dfs next-node (+ current-time time) (+ current-quality (list-ref values next-node)))
                (hash-update! visited next-node sub1)
                (when (zero? (hash-ref visited next-node))
                  (hash-remove! visited next-node)))))))

  (dfs 0 0 (list-ref values 0))
  max-quality)