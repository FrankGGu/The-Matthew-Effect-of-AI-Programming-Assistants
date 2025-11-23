(define trie%
  (class object%
    (init-field children (make-hash))
    (init-field is-end? #f)
    (define/public (insert word)
      (define (insert-helper node str)
        (cond
          [(empty? str) (set! (get-field is-end? node) #t)]
          [else
           (let* ([c (string->symbol (substring str 0 1))]
                  [next-str (substring str 1)])
             (if (hash-has-key? (get-field children node) c)
                 (insert-helper (hash-ref (get-field children node) c) next-str)
                 (let ([new-node (new trie%)])
                   (hash-set! (get-field children node) c new-node)
                   (insert-helper new-node next-str))))]))
      (insert-helper this word))
    (define/public (search word)
      (define (search-helper node str)
        (cond
          [(empty? str) (get-field is-end? node)]
          [else
           (let* ([c (string->symbol (substring str 0 1))]
                  [next-str (substring str 1)])
             (if (hash-has-key? (get-field children node) c)
                 (search-helper (hash-ref (get-field children node) c) next-str)
                 #f))]))
      (search-helper this word))
    (define/public (starts-with prefix)
      (define (starts-with-helper node str)
        (cond
          [(empty? str) #t]
          [else
           (let* ([c (string->symbol (substring str 0 1))]
                  [next-str (substring str 1)])
             (if (hash-has-key? (get-field children node) c)
                 (starts-with-helper (hash-ref (get-field children node) c) next-str)
                 #f))]))
      (starts-with-helper this prefix))))