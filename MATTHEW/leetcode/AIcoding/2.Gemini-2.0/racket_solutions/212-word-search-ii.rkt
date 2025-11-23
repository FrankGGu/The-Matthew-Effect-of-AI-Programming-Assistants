(define (find-words board words)
  (define rows (length board))
  (define cols (length (car board)))
  (define trie (build-trie words))
  (define result (set))

  (define (dfs row col node path)
    (cond
      [(or (< row 0) (>= row rows) (< col 0) (>= col cols)) #f]
      [(set-member? path (list row col)) #f]
      [else
       (let* ([char (list-ref (list-ref board row) col)]
              [next-node (hash-ref node char #f)])
         (cond
           [(not next-node) #f]
           [else
            (let ([new-path (set-add path (list row col))])
              (when (hash-has-key? next-node "word")
                (set! result (set-add result (hash-ref next-node "word"))))
              (dfs (add1 row) col next-node new-path)
              (dfs (sub1 row) col next-node new-path)
              (dfs row (add1 col) next-node new-path)
              (dfs row (sub1 col) next-node new-path)
              #t))))]))

  (define (build-trie words)
    (define trie (hash))
    (for-each
     (lambda (word)
       (let loop ([node trie] [chars (string->list word)])
         (cond
           [(empty? chars) (hash-set! node "word" word)]
           [else
            (let ([char (car chars)])
              (unless (hash-has-key? node char)
                (hash-set! node char (hash)))
              (loop (hash-ref node char) (cdr chars)))])))
     words)
    trie)

  (for ([row (in-range rows)])
    (for ([col (in-range cols)])
      (dfs row col trie (set))))

  (set->list result))