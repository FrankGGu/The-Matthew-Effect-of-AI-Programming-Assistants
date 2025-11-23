#lang racket

(define (max-xor nums limit)
  (define (build-trie nums)
    (define trie (make-hash))
    (for-each
     (lambda (num)
       (let loop ((node trie) (bit 30))
         (when (>= bit 0)
           (define b (bitwise-and (arithmetic-shift num (- bit)) 1))
           (unless (hash-has-key? node b)
             (hash-set! node b (make-hash)))
           (loop (hash-ref node b) (- bit 1)))))
    trie)

  (define (query trie num)
    (let loop ((node trie) (bit 30) (max-xor 0))
      (when (>= bit 0)
        (define b (bitwise-and (arithmetic-shift num (- bit)) 1))
        (define target (if (= b 1) 0 1))
        (if (hash-has-key? node target)
            (loop (hash-ref node target) (- bit 1) (bitwise-ior max-xor (arithmetic-shift 1 bit)))
            (loop (hash-ref node b) (- bit 1) max-xor)))
      max-xor))

  (define trie (build-trie nums))
  (for/list ((num nums)) (query trie num)))