#lang racket

(struct TrieNode (children is-end-of-word?))

(define (TrieNode-new)
  (TrieNode (make-hash) #f))

(define Trie%
  (class object%
    (field [root (TrieNode-new)])

    (define/public (init)
      (set! root (TrieNode-new)))

    (define/public (insert word)
      (define current root)
      (for ([c (string->list word)])
        (define children (TrieNode-children current))
        (unless (hash-has-key? children c)
          (hash-set! children c (TrieNode-new)))
        (set! current (hash-ref children c)))
      (set-TrieNode-is-end-of-word?! current #t))

    (define/private (get-node prefix)
      (define current root)
      (for ([c (string->list prefix)])
        (define children (TrieNode-children current))
        (unless (hash-has-key? children c)
          (set! current #f)
          (break))
        (set! current (hash-ref children c)))
      current)

    (define/public (search word)
      (define node (get-node word))
      (and node (TrieNode-is-end-of-word? node)))

    (define/public (starts-with prefix)
      (boolean (get-node prefix)))
    ))