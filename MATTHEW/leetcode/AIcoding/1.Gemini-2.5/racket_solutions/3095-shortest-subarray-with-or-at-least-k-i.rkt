#lang racket

(require racket/hash)
(require racket/list)

(define (shortest-subarray-with-or-at-least-k nums k)
  (define n (length nums))
  (define min-len (add1 n)) ; Initialize with a value larger than any possible length

  ;; current-ors: a list of (or-value start-index) pairs
  ;; representing distinct OR sums for subarrays ending at (j-1),
  ;; each with its smallest starting index.
  (define current-ors '())

  (for ([j (in-range n)])
    (define num-j (list-ref nums j))

    ;; temp-ors will collect all potential (or-value start-index) pairs
    ;; for subarrays ending at j.
    (define temp-ors '())

    ;; Add the single element subarray ending at j
    (set! temp-ors (cons (list num-j j) temp-ors))

    ;; Extend previous subarrays (ending at j-1) by ORing with num-j
    (for-each (lambda (p)
                (define prev-or (list-ref p 0))
                (define prev-start (list-ref p 1))
                (set! temp-ors (cons (list (| prev-or num-j) prev-start) temp-ors)))
              current-ors)

    ;; Consolidate temp-ors to get the unique OR sums with their minimum start indices.
    ;; Use a hash map for efficient consolidation.
    (define or-map (make-hash))
    (for-each (lambda (p)
                (define val (list-ref p 0))
                (define start-idx (list-ref p 1))
                (if (or (not (hash-has-key? or-map val))
                        (< start-idx (hash-ref or-map val)))
                    (hash-set! or-map val start-idx)))
              temp-ors)

    ;; Convert the hash map back to a sorted list of (or-value start-index) pairs.
    ;; This sorted list becomes current-ors for the next iteration.
    (set! current-ors
          (sort (hash-map->list or-map (lambda (k v) (list k v)))
                (lambda (a b) (< (list-ref a 0) (list-ref b 0)))))

    ;; Check all consolidated OR sums for the current ending index j
    ;; and update min-len if a valid subarray is found.
    (for-each (lambda (p)
                (define or-val (list-ref p 0))
                (define start-idx (list-ref p 1))
                (when (>= or-val k)
                  (set! min-len (min min-len (add1 (- j start-idx))))))
              current-ors))

  ;; If min-len is still its initial value, no valid subarray was found.
  (if (= min-len (add1 n))
      -1
      min-len))