#lang racket

(define (max-genetic-difference parents queries)
  (define n (length parents))
  (define root -1)
  (define children (make-hash))
  (for ([(p i) (in-indexed parents)])
    (if (= p -1)
        (set! root i)
        (hash-update! children p (lambda (lst) (cons i lst)) '())))

  (define trie-root (make-hash))

  (define (insert num)
    (let loop ([node trie-root] [bit 18])
      (when (>= bit 0)
        (define b (bitwise-bit-field num bit (+ bit 1)))
        (hash-update! node b (lambda (n) (or n (make-hash))) (make-hash))
        (loop (hash-ref node b) (- bit 1)))))
    (hash-update! trie-root 'count (lambda (x) (+ x 1)) 0))

  (define (remove num)
    (let loop ([node trie-root] [bit 18])
      (when (>= bit 0)
        (define b (bitwise-bit-field num bit (+ bit 1)))
        (define next-node (hash-ref node b))
        (loop next-node (- bit 1))
        (when (zero? (hash-ref next-node 'count 0))
          (hash-remove! node b))))
    (hash-update! trie-root 'count (lambda (x) (- x 1)) 0)

  (define (query num)
    (let loop ([node trie-root] [bit 18] [res 0])
      (if (< bit 0)
          res
          (let* ([b (bitwise-bit-field num bit (+ bit 1))]
                 [target (bitwise-xor b 1)]
                 (if (hash-has-key? node target)
                     (loop (hash-ref node target) (- bit 1) (+ res (arithmetic-shift 1 bit)))
                     (loop (hash-ref node b) (- bit 1) res))))))

  (define qs (make-hash))
  (for ([(q idx) (in-indexed queries)])
    (hash-update! qs (cadr q) (lambda (lst) (cons (cons (car q) idx) lst)) '()))

  (define result (make-vector (length queries) 0))

  (define (dfs u)
    (insert u)
    (for ([pair (in-list (hash-ref qs u '()))])
      (define node (car pair))
      (define idx (cdr pair))
      (vector-set! result idx (query node)))
    (for ([v (in-list (hash-ref children u '()))])
      (dfs v))
    (remove u))

  (dfs root)
  (vector->list result))