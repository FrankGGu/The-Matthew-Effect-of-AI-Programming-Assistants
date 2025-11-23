#lang racket

(define (substring-xor-queries s queries)
  (define n (string-length s))
  ;; Maximum length of a binary substring to consider.
  ;; If `first_i` is expected to fit within a 32-bit signed integer, max_len is around 31.
  ;; If `first_i` can be a 64-bit integer, max_len is around 63.
  ;; We choose 60 as a reasonable upper bound for typical LeetCode integer values.
  (define max-len 60)

  ;; `results` will store a mapping from `(decimal_value . xor_sum)` to `(start_index . end_index)`.
  ;; We use a hash table for efficient lookups.
  (define results (make-hash))

  ;; Precompute all valid substrings and their properties.
  ;; Iterate through all possible starting indices `l`.
  (for ([l (in-range n)])
    (define current-val 0)
    (define current-xor-sum 0)
    ;; Iterate through possible ending indices `r`, limited by `max-len`.
    (for ([r (in-range l (min n (+ l max-len)))])
      ;; Convert character '0' or '1' to integer 0 or 1.
      (define digit (- (char->integer (string-ref s r)) (char->integer #\0)))

      ;; Update the decimal value of the binary substring s[l...r].
      ;; Racket's integers have arbitrary precision, so overflow is not a concern
      ;; for `current-val` itself, but `first_i` in queries will have a practical limit.
      (set! current-val (+ (* current-val 2) digit))

      ;; Update the XOR sum of the digits in the substring.
      (set! current-xor-sum (bitwise-xor current-xor-sum digit))

      ;; Create a key for the hash table: a pair of (decimal_value . xor_sum).
      (define key (cons current-val current-xor-sum))

      ;; If this combination of (value, xor_sum) has not been seen before,
      ;; store its corresponding (l, r) indices.
      ;; The problem asks for *any* such substring, so the first one found is sufficient.
      (when (not (hash-has-key? results key))
        (hash-set! results key (cons l r))))))

  ;; Process each query.
  ;; `for/list` iterates over the `queries` vector and collects results into a list.
  (for/list ([query (in-vector queries)])
    (define first_i (vector-ref query 0))
    (define second_i (vector-ref query 1))
    (define key (cons first_i second_i)) ; Create the key to look up in `results`.

    ;; Check if a matching substring was found during precomputation.
    (if (hash-has-key? results key)
        ;; If found, return its (l, r) indices as a list.
        (list (car (hash-ref results key)) (cdr (hash-ref results key)))
        ;; Otherwise, return [-1, -1].
        (list -1 -1))))