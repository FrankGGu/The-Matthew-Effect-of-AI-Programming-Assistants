(define (maximum-value strs)
  (define (get-string-value s)
    ;; Check if all characters in 's' are numeric (0-9)
    (if (for/all ([c (in-string s)]) (char-numeric? c))
        ;; If all are numeric, convert to integer
        (string->number s)
        ;; Otherwise, its value is its length
        (string-length s)))

  ;; Iterate through the list of strings, accumulating the maximum value
  (for/fold ([max-val 0]) ; Initialize max-val to 0, as problem values are non-negative
            ([s strs])
    (max max-val (get-string-value s))))