#lang racket

(define (longest-special-path n edges)
  (define graph (make-hash))
  (for-each (lambda (edge)
              (let ([u (car edge)]
                    [v (cadr edge)])
                (hash-set! graph u (cons v (hash-ref graph u '())))
                (hash-set! graph v (cons u (hash-ref graph v '())))))
            edges)

  (define visited (make-hash))
  (define max-length 0)

  (define (dfs node parent)
    (let ([current-length 1])
      (for-each (lambda (neighbor)
                  (when (not (= neighbor parent))
                    (let ([length (dfs neighbor node)])
                      (when (> length 0)
                        (set! current-length (+ current-length length))))))
                (hash-ref graph node '()))
      current-length))

  (for-each (lambda (node)
              (set! max-length (max max-length (dfs node -1))))
            (range n))

  max-length)