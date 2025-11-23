#lang racket

(define-struct trie-node (children end-of-word?))

(define (make-trie-node)
  (trie-node (make-hash) #f))

(define WordDictionary%
  (class object
    (init-field [root (make-trie-node)])

    (define/public (addWord word)
      (define current root)
      (for ([char (string->list word)])
        (define children (trie-node-children current))
        (unless (hash-has-key? children char)
          (hash-set! children char (make-trie-node)))
        (set! current (hash-ref children char)))
      (set-trie-node-end-of-word?! current #t))

    (define/public (search word)
      (define (search-helper node word-list-chars)
        (cond
          [(null? word-list-chars)
           (and node (trie-node-end-of-word? node))]
          [(not node)
           #f]
          [else
           (define char (car word-list-chars))
           (define rest-chars (cdr word-list-chars))
           (define children (trie-node-children node))

           (cond
             [(char=? char #\.)
              (ormap (lambda (child-node)
                       (search-helper child-node rest-chars))
                     (hash-values children))]
             [else ; regular character
              (define next-node (hash-ref children char #f))
              (search-helper next-node rest-chars)])]))
      (search-helper root (string->list word))))

(provide WordDictionary%)