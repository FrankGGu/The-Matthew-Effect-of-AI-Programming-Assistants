(require racket/hash)
(require racket/vector)
(require racket/string)

(define (concatenated-words words)
  (define all-words-set (make-hash))
  (for-each (lambda (w) (hash-set! all-words-set w #t)) words)

  (define (is-concatenated? current-word)
    (define temp-word-set (make-hash))
    (hash-for-each (lambda (k v) (hash-set! temp-word-set k v)) all-words-set)
    (hash-remove! temp-word-set current-word)

    (define len (string-length current-word))
    (define dp-vec (make-vector (add1 len) +inf.0))
    (vector-set! dp-vec len 0)

    (for i (sub1 len) -1 -1)
      (for j (add1 i) (add1 len))
        (define prefix (substring current-word i j))
        (when (hash-has-key? temp-word-set prefix)
          (define num-words-for-suffix (vector-ref dp-vec j))
          (unless (= num-words-for-suffix +inf.0)
            (vector-set! dp-vec i
                         (min (vector-ref dp-vec i)
                              (add1 num-words-for-suffix))))))

    (define min-words (vector-ref dp-vec 0))
    (and (not (= min-words +inf.0)) (>= min-words 2)))

  (filter is-concatenated? words))