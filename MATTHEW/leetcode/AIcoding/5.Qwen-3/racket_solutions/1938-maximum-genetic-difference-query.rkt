#lang racket

(define (make-trie)
  (list (vector) (vector)))

(define (insert trie num)
  (let loop ([node (car trie)] [bit 60])
    (if (= bit -1)
        (void)
        (let ([b (bitwise-and (arithmetic-shift num (- bit)) 1)])
          (if (vector-ref node b)
              (loop (vector-ref node b) (- bit 1))
              (begin
                (vector-set! node b (make-trie))
                (loop (vector-ref node b) (- bit 1))))))))

(define (query trie num)
  (let loop ([node (car trie)] [bit 60] [max-val 0])
    (if (= bit -1)
        max-val
        (let ([b (bitwise-and (arithmetic-shift num (- bit)) 1)])
          (if (vector-ref node (- 1 b))
              (loop (vector-ref node (- 1 b)) (- bit 1) (bitwise-ior max-val (arithmetic-shift 1 bit)))
              (loop (vector-ref node b) (- bit 1) max-val))))))

(define (maximum-genetic-difference-queries parent queries)
  (define n (length parent))
  (define adj (make-vector n '()))
  (for ([i (in-range n)])
    (when (not (= (vector-ref parent i) -1))
      (vector-set! adj (vector-ref parent i) (cons i (vector-ref adj (vector-ref parent i))))))
  (define res (make-vector (length queries) 0))
  (define trie (make-trie))
  (define (dfs u p)
    (insert trie u)
    (for-each (lambda (q)
                (let ([idx (car q)]
                      [v (cadr q)])
                  (vector-set! res idx (query trie v))))
              (filter (lambda (q) (= (car q) u)) queries))
    (for-each (lambda (v)
                (when (not (= v p))
                  (dfs v u)))
              (vector-ref adj u))
    (begin
      (insert trie u)
      (void)))
  (dfs 0 -1)
  (vector->list res))