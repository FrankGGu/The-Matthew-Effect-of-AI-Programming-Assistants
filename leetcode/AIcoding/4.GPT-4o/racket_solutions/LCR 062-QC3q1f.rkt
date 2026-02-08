#lang racket

(define TrieNode
  (struct: TrieNode (children is-end)))

(define Trie
  (struct: Trie (root)))

(define (make-trie)
  (Trie (TrieNode (make-vector 26) #f)))

(define (insert trie word)
  (define current (trie-root trie))
  (for ([char (string->list word)])
    (define index (- (char->integer char) (char->integer #\a)))
    (unless (vector-ref (TrieNode-children current) index)
      (vector-set! (TrieNode-children current) index (TrieNode (make-vector 26) #f)))
    (set! current (vector-ref (TrieNode-children current) index)))
  (set! (TrieNode-is-end current) #t))

(define (search trie word)
  (define current (trie-root trie))
  (for ([char (string->list word)])
    (define index (- (char->integer char) (char->integer #\a)))
    (set! current (vector-ref (TrieNode-children current) index))
    (when (not current) (return #f)))
  (TrieNode-is-end current))

(define (starts-with trie prefix)
  (define current (trie-root trie))
  (for ([char (string->list prefix)])
    (define index (- (char->integer char) (char->integer #\a)))
    (set! current (vector-ref (TrieNode-children current) index))
    (when (not current) (return #f)))
  #t)