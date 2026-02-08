(define trie%
  (class object%
    (init-field prefix)
    (define/public (insert word)
      (define (insert-helper node word)
        (cond [(empty? word) (hash-set! node #f #t)]
              [else
               (define c (string-ref word 0))
               (define sub (substring word 1))
               (unless (hash-has-key? node c)
                 (hash-set! node c (make-hash)))
               (insert-helper (hash-ref node c) sub)]))
      (insert-helper prefix word))
    (define/public (search word)
      (define (search-helper node word)
        (cond [(empty? word) (hash-has-key? node #f)]
              [else
               (define c (string-ref word 0))
               (define sub (substring word 1))
               (if (hash-has-key? node c)
                   (search-helper (hash-ref node c) sub)
                   #f)]))
      (search-helper prefix word))
    (define/public (starts-with prefix)
      (define (starts-with-helper node prefix)
        (cond [(empty? prefix) #t]
              [else
               (define c (string-ref prefix 0))
               (define sub (substring prefix 1))
               (if (hash-has-key? node c)
                   (starts-with-helper (hash-ref node c) sub)
                   #f)]))
      (starts-with-helper prefix prefix))
    (super-new)))

(define Trie
  (lambda ()
    (new trie% [prefix (make-hash)])))