(define (maximum-number-of-non-overlapping-substrings s)
  (define n (string-length s))

  (define first (make-vector 26 n)) ; Stores first occurrence index, initialized to n
  (define last (make-vector 26 -1)) ; Stores last occurrence index, initialized to -1

  ;; Initialize first occurrences to n (a value larger than any valid index)
  (for ([idx (in-range 26)])
    (vector-set! first idx n))

  ;; Populate first and last occurrence arrays
  (for ([i (in-range n)])
    (define char-code (- (char->integer (string-ref s i)) (char->integer #\a)))
    (when (= (vector-ref first char-code) n)
      (vector-set! first char-code i))
    (vector-set! last char-code i))

  (define result '())
  (define i 0)
  (while (< i n)
    (define char-code-i (- (char->integer (string-ref s i)) (char->integer #\a)))
    (define current-max-end (vector-ref last char-code-i))
    (define j i)
    (define is-valid-start #t)

    ;; Expand the segment [i, current-max-end]
    ;; Check if any character within this segment starts before 'i'
    ;; And extend 'current-max-end' if any character ends later
    (while (and is-valid-start (<= j current-max-end))
      (define char-code-j (- (char->integer (string-ref s j)) (char->integer #\a)))
      (when (< (vector-ref first char-code-j) i)
        ;; Character s[j] starts before 'i', so 'i' cannot be the start of a valid substring.
        (set! is-valid-start #f))
      (set! current-max-end (max current-max-end (vector-ref last char-code-j)))
      (set! j (+ j 1)))

    (when is-valid-start
      ;; If 'i' is a valid start, then s[i ... current-max-end] is a valid substring.
      ;; Add it to the result and jump 'i' past this substring.
      (set! result (cons (substring s i (+ current-max-end 1)) result))
      (set! i (+ current-max-end 1)))

    (unless is-valid-start
      ;; If 'i' is not a valid start, just move to the next character.
      (set! i (+ i 1))))

    (reverse result))