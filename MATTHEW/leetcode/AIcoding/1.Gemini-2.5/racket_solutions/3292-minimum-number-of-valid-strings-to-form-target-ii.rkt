#lang racket/base

(require racket/vector)
(require racket/hash)
(require racket/string)

(define +inf.0 (expt 10 9)) ; A sufficiently large number for infinity.

(struct trie-node (children is-word? has-word-starting-here?) #:mutable)

(define (build-trie words)
  (define root (trie-node (make-hash) #f #f))
  (for-each (lambda (word)
              (let loop ((node root) (idx 0))
                (if (= idx (string-length word))
                    (set-trie-node-is-word?! node #t)
                    (let* ((char (string-ref word idx))
                           (child (hash-ref (trie-node-children node) char #f)))
                      (unless child
                        (set! child (trie-node (make-hash) #f #f))
                        (hash-set! (trie-node-children node) char child))
                      (loop child (+ idx 1))))))
            words)
  root)

(define (compute-has-word-starting-here! node)
  (set-trie-node-has-word-starting-here?! node (trie-node-is-word? node))
  (hash-for-each
   (lambda (char child)
     (when (compute-has-word-starting-here! child)
       (set-trie-node-has-word-starting-here?! node #t)))
   (trie-node-children node))
  (trie-node-has-word-starting-here? node))

(define (minimum-number-of-valid-strings-to-form-target-ii target dictionary)
  (define n (string-length target))
  (define dp (make-vector (+ n 1) +inf.0))
  (vector-set! dp 0 0)

  (define forward-trie (build-trie dictionary))
  (compute-has-word-starting-here! forward-trie)

  (define reversed-dict (map string-reverse dictionary))
  (define reversed-trie (build-trie reversed-dict))
  (compute-has-word-starting-here! reversed-trie)

  (for ((i (in-range 1 (+ n 1))))
    ;; Case 1: target[0...i-1] is a suffix of some dictionary string s.
    ;; This means reversed(s) starts with reversed(target[0...i-1]).
    ;; We traverse the reversed trie with target[i-1] then target[i-2] ... target[0].
    (let loop-reversed ((current-node reversed-trie) (k (- i 1)))
      (when (>= k 0)
        (let* ((char (string-ref target k))
               (child (hash-ref (trie-node-children current-node) char #f)))
          (when child
            (set! current-node child)
            (when (and (= k 0) (trie-node-has-word-starting-here? current-node))
              (vector-set! dp i (min (vector-ref dp i) 1)))
            (loop-reversed current-node (- k 1))))))

    ;; Case 2: target[0...i-1] is a suffix of (S_prev + s), where S_prev has target[0...j-1] as its suffix.
    ;; This means target[j...i-1] is a prefix of some dictionary string s.
    ;; We iterate j from i-1 down to 0.
    ;; current-node will represent the prefix target[j...i-1] in the forward trie.
    (let loop-forward ((current-node forward-trie) (j (- i 1)))
      (when (>= j 0)
        (let* ((char (string-ref target j))
               (child (hash-ref (trie-node-children current-node) char #f)))
          (when child
            (set! current-node child)
            (when (trie-node-has-word-starting-here? current-node)
              (when (not (= (vector-ref dp j) +inf.0))
                (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp j) 1)))))
            (loop-forward current-node (- j 1)))))))

  (let ((result (vector-ref dp n)))
    (if (= result +inf.0)
        -1
        result)))