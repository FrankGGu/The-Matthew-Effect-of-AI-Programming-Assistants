#lang racket

(define (num-matching-subseq s words)
  (define (char->index c)
    (- (char->integer c) (char->integer #\a)))

  (define (build-trie)
    (let ([root (make-hash)])
      (for ([word words])
        (let loop ([node root] [i 0])
          (when (< i (string-length word))
            (let ([c (string-ref word i)])
              (unless (hash-has-key? node c)
                (hash-set! node c (make-hash)))
              (loop (hash-ref node c) (+ i 1))))))
      root))

  (define (count-matches trie)
    (define (dfs node pos)
      (if (null? node)
          0
          (let ([count 0])
            (when (and (hash-has-key? node 'end) (hash-ref node 'end))
              (set! count (+ count 1)))
            (for ([c (in-hash-keys node)])
              (when (not (equal? c 'end))
                (let ([next-node (hash-ref node c)])
                  (set! count (+ count (dfs next-node pos))))))
            count))
    (dfs trie 0))

  (define (main)
    (define trie (build-trie))
    (count-matches trie))

  (main))

(define (solve)
  (define s (read-line))
  (define n (string->number (read-line)))
  (define words (for/list ([i n]) (read-line)))
  (num-matching-subseq s words))

(solve)