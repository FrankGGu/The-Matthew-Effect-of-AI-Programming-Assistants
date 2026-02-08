#lang racket/base

(require racket/hash)
(require racket/vector)
(require racket/list)

(define (closest-equal-element-queries nums queries)
  (let* ((n (length nums))
         (nums-vec (list->vector nums))
         (val-to-indices (make-hash)))

    ;; Pre-processing: Populate hash table with value -> list of indices
    ;; Using cons to prepend, then reverse to get sorted order.
    (for ([i (in-range n)])
      (let ((val (vector-ref nums-vec i)))
        (hash-set! val-to-indices val (cons i (hash-ref val-to-indices val '())))))

    ;; Convert lists of indices to sorted vectors for O(1) access and O(log N) binary search
    (for ([(val indices-list) (in-hash val-to-indices)])
      (hash-set! val-to-indices val (list->vector (reverse indices-list))))

    ;; Helper for binary search on a sorted vector
    ;; Assumes target is guaranteed to be in the vector.
    (define (binary-search-vector vec target)
      (let loop ((low 0)
                 (high (- (vector-length vec) 1)))
        (let* ((mid (+ low (quotient (- high low) 2)))
               (val (vector-ref vec mid)))
          (cond
            ((= val target) mid)
            ((< val target) (loop (+ mid 1) high))
            (else (loop low (- mid 1)))))))

    ;; Process queries
    (for/list ([q-idx (in-list queries)])
      (let* ((target-val (vector-ref nums-vec q-idx))
             (indices-vec (hash-ref val-to-indices target-val #f)))
        (cond
          ;; If no other equal elements exist
          ((or (not indices-vec) (<= (vector-length indices-vec) 1))
           -1)
          (else
           (let* ((pos (binary-search-vector indices-vec q-idx))
                  (min-diff (add1 n)) ; Initialize with a value larger than any possible difference
                  (ans-idx -1))

             ;; Check left neighbor
             (when (> pos 0)
               (let* ((left-idx (vector-ref indices-vec (- pos 1)))
                      (diff (- q-idx left-idx)))
                 (set! min-diff diff)
                 (set! ans-idx left-idx)))

             ;; Check right neighbor
             (when (< pos (- (vector-length indices-vec) 1))
               (let* ((right-idx (vector-ref indices-vec (+ pos 1)))
                      (diff (- right-idx q-idx)))
                 (cond
                   ((< diff min-diff)
                    (set! min-diff diff)
                    (set! ans-idx right-idx))
                   ((= diff min-diff)
                    ;; Tie-breaking: return the smaller index
                    (set! ans-idx (min ans-idx right-idx))))))
             ans-idx))))))