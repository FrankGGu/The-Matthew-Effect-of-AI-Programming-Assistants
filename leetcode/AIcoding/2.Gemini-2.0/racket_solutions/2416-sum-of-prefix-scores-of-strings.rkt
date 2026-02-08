(define (sum-prefix-scores words)
  (define trie (make-hash))
  (define (insert word)
    (define (insert-helper current-node chars)
      (cond
        [(empty? chars) (hash-set! current-node '#end #t)]
        [else
         (let* ([char (car chars)]
                [next-node (hash-ref current-node char #f)])
           (if next-node
               (begin
                 (hash-set! current-node char (hash-set next-node 'count (+ 1 (hash-ref next-node 'count 0))))
                 (insert-helper next-node (cdr chars)))
               (begin
                 (define new-node (make-hash))
                 (hash-set! new-node 'count 1)
                 (hash-set! current-node char new-node)
                 (insert-helper new-node (cdr chars)))))]))
    (insert-helper trie (string->list word)))

  (define (build-trie)
    (for-each insert words))

  (define (calculate-score word)
    (define (calculate-helper current-node chars score)
      (cond
        [(empty? chars) score]
        [else
         (let* ([char (car chars)]
                [next-node (hash-ref current-node char #f)])
           (if next-node
               (calculate-helper next-node (cdr chars) (+ score (hash-ref next-node 'count 0)))
               score))]))
    (calculate-helper trie (string->list word) 0))

  (build-trie)
  (map calculate-score words))