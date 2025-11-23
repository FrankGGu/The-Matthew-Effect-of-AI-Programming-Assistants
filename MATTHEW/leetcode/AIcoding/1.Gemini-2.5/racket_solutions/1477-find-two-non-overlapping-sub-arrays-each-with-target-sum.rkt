#lang racket

(define (min-sum-of-lengths arr target)
  (define n (vector-length arr))
  (define min-len-prefix (make-vector n +inf.0)) ; min length of a valid subarray ending at or before index i
  (define prefix-sums (make-hash))
  (hash-set! prefix-sums 0 -1) ; sum 0 found before index 0
  (define current-sum 0)
  (define min-total-length +inf.0)

  (for ([i (in-range n)])
    (set! current-sum (+ current-sum (vector-ref arr i)))

    ; Update min-len-prefix[i] based on min-len-prefix[i-1]
    (when (> i 0)
      (vector-set! min-len-prefix i (vector-ref min-len-prefix (- i 1))))

    ; Check if a sub-array ending at i with target sum exists
    (when (hash-has-key? prefix-sums (- current-sum target))
      (define start-idx (+ (hash-ref prefix-sums (- current-sum target)) 1))
      (define len (- i start-idx -1)) ; length is i - start-idx + 1

      ; If there's a valid sub-array ending strictly before start-idx
      (when (and (> start-idx 0)
                 (not (eq? (vector-ref min-len-prefix (- start-idx 1)) +inf.0)))
        (set! min-total-length (min min-total-length
                                    (+ (vector-ref min-len-prefix (- start-idx 1)) len))))

      ; Update min-len-prefix[i] with the length of the current sub-array if it's smaller
      (vector-set! min-len-prefix i (min (vector-ref min-len-prefix i) len)))

    (hash-set! prefix-sums current-sum i))

  (if (eq? min-total-length +inf.0)
      -1
      min-total-length))