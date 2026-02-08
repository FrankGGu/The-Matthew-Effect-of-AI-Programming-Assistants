#lang racket

(struct trie-node (children word-end-count) #:transparent)

(define (make-trie-node)
  (trie-node (make-hash) 0))

(define P 31)
(define M 1000000007)

(define (char-val c)
  (+ (- (char->integer c) (char->integer #\a)) 1))

(define (get-prefix-hashes s)
  (let* ([n (string-length s)]
         [hashes (make-vector (+ n 1) 0)])
    (for ([k (in-range 1 (+ n 1))])
      (vector-set! hashes k
                   (modulo (+ (* (vector-ref hashes (- k 1)) P)
                              (char-val (string-ref s (- k 1))))
                           M)))
    hashes))

(define (count-prefix-and-suffix-pairs-ii words)
  (let* ([root (make-trie-node)]
         [total-pairs 0])

    (for ([word words])
      (let* ([n (string-length word)]
             [h-pref (get-prefix-hashes word)]
             [word-rev (string-reverse word)]
             [h-suff (get-prefix-hashes word-rev)])

        (let query-loop ([k 1] [current-trie-node root])
          (when (<= k n)
            (let* ([char (string-ref word (- k 1))]
                   [child (hash-ref (trie-node-children current-trie-node) char #f)])
              (when child
                (when (= (vector-ref h-pref k) (vector-ref h-suff k))
                  (set! total-pairs (+ total-pairs (trie-node-word-end-count child))))
                (query-loop (+ k 1) child)))))

        (let insert-loop ([k 0] [current-trie-node root])
          (if (< k n)
              (let* ([char (string-ref word k)]
                     [children (trie-node-children current-trie-node)]
                     [child (hash-ref children char #f)])
                (unless child
                  (set! child (make-trie-node))
                  (hash-set! children char child))
                (insert-loop (+ k 1) child))
              (set-trie-node-word-end-count! current-trie-node
                                             (+ (trie-node-word-end-count current-trie-node) 1))))))
    total-pairs))