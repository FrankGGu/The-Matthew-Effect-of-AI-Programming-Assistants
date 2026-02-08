#lang racket

(define (bit-update! bit idx val)
  (let* ((n (vector-length bit)) ; n is the size of the internal 1-indexed vector
         (i (+ idx 1)))          ; Convert to 1-indexed
    (when (>= i n)
      (error "bit-update!: index out of bounds"))
    (let loop ()
      (when (< i n)
        (vector-set! bit i (+ (vector-ref bit i) val))
        (set! i (+ i (bitwise-and i (- i)))) ; i += i & (-i)
        (loop)))))

(define (bit-query bit idx)
  (if (< idx 0)
      0 ; No elements to sum if the target index is negative
      (let* ((n (vector-length bit))
             (i (+ idx 1))) ; Convert to 1-indexed
        (when (>= i n)
          (error "bit-query!: index out of bounds"))
        (let loop ((sum 0))
          (if (zero? i)
              sum
              (loop (+ sum (vector-ref bit i))
                    (- i (bitwise-and i (- i))))))))) ; i -= i & (-i)

(define (count-the-number-of-substrings-with-dominant-ones s)
  (let* ((n (string-length s))
         ;; Prefix sums can range from -n to n.
         ;; We map these sums to 0-indexed BIT indices: sum + offset.
         ;; The range of mapped indices will be from 0 (for -n) to 2n (for n).
         ;; So, the maximum 0-indexed value is 2n.
         ;; A 1-indexed BIT of size `max_idx + 1` handles up to `max_idx`.
         ;; Thus, internal BIT vector size needs to be `2n + 1 + 1 = 2n + 2`.
         (bit-size (+ (* 2 n) 2))
         (offset n) ; Offset to make sums non-negative for BIT indices
         (bit (make-vector bit-size 0)) ; Initialize BIT with zeros
         (total-count 0)
         (current-sum 0))

    ;; Initialize BIT for the empty prefix sum (P[0] = 0).
    ;; This represents the state before processing any characters.
    (bit-update! bit (+ current-sum offset) 1)

    ;; Iterate through the string, calculating prefix sums
    (for ([k (in-range n)])
      (let ((ch (string-ref s k)))
        ;; Update current_sum based on the character
        (set! current-sum (+ current-sum (if (char=? ch #\1) 1 -1)))

        ;; Query the BIT for the count of previous prefix sums P[i]
        ;; such that P[i] < current_sum (P[j] > P[i]).
        ;; The BIT stores frequencies of (sum + offset).
        ;; So, we need to query for values less than (current_sum + offset).
        ;; This means querying up to index (current_sum + offset - 1).
        (set! total-count (+ total-count (bit-query bit (- (+ current-sum offset) 1))))

        ;; Add the current prefix sum P[k+1] to the BIT
        (bit-update! bit (+ current-sum offset) 1))))

    total-count))