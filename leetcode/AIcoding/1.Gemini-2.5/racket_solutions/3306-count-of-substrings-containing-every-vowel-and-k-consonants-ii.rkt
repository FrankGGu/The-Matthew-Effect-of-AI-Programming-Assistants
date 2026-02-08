#lang racket

(define (is-vowel? c)
  (or (char=? c #\a) (char=? c #\e) (char=? c #\i) (char=? c #\o) (char=? c #\u)))

(define (vowel-char-to-idx c)
  (cond
    ((char=? c #\a) 0)
    ((char=? c #\e) 1)
    ((char=? c #\i) 2)
    ((char=? c #\o) 3)
    ((char=? c #\u) 4)
    (else -1))) ; Should not happen for vowels

(define (count-exactly-vowels-at-most-consonants s max-consonants)
  (define n (string-length s))
  (let ((ans 0)
        (left-c 0) ; Left pointer for the window [left-c, right] satisfying C <= max-consonants
        (consonant-count 0)
        (vowel-counts-c (make-vector 5 0)) ; Vowel counts for window [left-c, right]

        (left-v 0) ; Left pointer for the window [left-v, right] satisfying V == 5
        (vowel-counts-v (make-vector 5 0)) ; Vowel counts for window [left-v, right]
        (distinct-vowel-count-v 0))

    (for ([right (in-range n)])
      (let ((char-right (string-ref s right)))
        ; --- Update for window [left-c, right] (consonant constraint) ---
        (if (is-vowel? char-right)
            (let ((idx (vowel-char-to-idx char-right)))
              (vector-set! vowel-counts-c idx (+ (vector-ref vowel-counts-c idx) 1)))
            (set! consonant-count (+ consonant-count 1)))

        ; Shrink left-c to satisfy consonant-count <= max-consonants
        (while (> consonant-count max-consonants)
          (let ((char-left-c (string-ref s left-c)))
            (if (is-vowel? char-left-c)
                (let ((idx (vowel-char-to-idx char-left-c)))
                  (vector-set! vowel-counts-c idx (- (vector-ref vowel-counts-c idx) 1)))
                (set! consonant-count (- consonant-count 1))))
          (set! left-c (+ left-c 1)))

        ; --- Update for window [left-v, right] (vowel constraint) ---
        (if (is-vowel? char-right)
            (let ((idx (vowel-char-to-idx char-right)))
              (when (= (vector-ref vowel-counts-v idx) 0)
                (set! distinct-vowel-count-v (+ distinct-vowel-count-v 1)))
              (vector-set! vowel-counts-v idx (+ (vector-ref vowel-counts-v idx) 1))))

        ; Ensure left-v is not behind left-c. If it is, advance it and update its counts.
        (while (< left-v left-c)
          (let ((char-left-v (string-ref s left-v)))
            (if (is-vowel? char-left-v)
                (let ((idx (vowel-char-to-idx char-left-v)))
                  (vector-set! vowel-counts-v idx (- (vector-ref vowel-counts-v idx) 1))
                  (when (= (vector-ref vowel-counts-v idx) 0)
                    (set! distinct-vowel-count-v (- distinct-vowel-count-v 1))))))
          (set! left-v (+ left-v 1)))

        ; Shrink left-v further to find the leftmost point where distinct-vowel-count-v == 5
        ; This loop finds the shortest window [left-v, right] that has all 5 vowels.
        ; When the loop finishes, left-v points to the first character that, if removed,
        ; would cause distinct-vowel-count-v to drop below 5.
        ; So, s[original_left-v ... right] (before this loop) is the shortest window.
        ; The current `left-v` is the first index that breaks the `V=5` condition.
        ; So, `left-v-1` is the rightmost valid start for `V=5`.
        (let ((current-left-v left-v)) ; Store left-v before starting the inner loop
          (while (and (<= current-left-v right) (= distinct-vowel-count-v 5))
            (let ((char-current-left-v (string-ref s current-left-v)))
              (if (is-vowel? char-current-left-v)
                  (let ((idx (vowel-char-to-idx char-current-left-v)))
                    (when (= (vector-ref vowel-counts-v idx) 1)
                      (set! distinct-vowel-count-v (- distinct-vowel-count-v 1)))
                    (vector-set! vowel-counts-v idx (- (vector-ref vowel-counts-v idx) 1))))
            (set! current-left-v (+ current-left-v 1))))
          ; After this loop, `current-left-v` is the first index that makes `s[current-left-v...right]` have < 5 distinct vowels.
          ; So, `current-left-v - 1` is the rightmost valid starting index for `V=5` (for a window ending at `right`).
          ; The range of valid starting points `x` for `V=5` is `[left-v_before_loop, current-left-v - 1]`.
          ; The range of valid starting points `x` for `C<=max-consonants` is `[left-c, right]`.
          ; We need the intersection of these ranges for `x`.
          ; The valid starting points `x` must be `>= left-c` and `<= (current-left-v - 1)`.
          ; The number of such `x` is `(current-left-v - 1) - left-c + 1`, which simplifies to `current-left-v - left-c`.
          ; This is only valid if `(current-left-v - 1) >= left-c`.
          (set! ans (+ ans (max 0 (- current-left-v left-c))))
          (set! left-v current-left-v) ; Update the main left-v pointer for next iteration
          ))
    ans))

(define (count-of-substrings-containing-every-vowel-and-k-consonants-ii s k)
  (let ((count-k (count-exactly-vowels-at-most-consonants s k))
        (count-k-minus-1 (if (> k 0) (count-exactly-vowels-at-most-consonants s (- k 1)) 0)))
    (- count-k count-k-minus-1)))