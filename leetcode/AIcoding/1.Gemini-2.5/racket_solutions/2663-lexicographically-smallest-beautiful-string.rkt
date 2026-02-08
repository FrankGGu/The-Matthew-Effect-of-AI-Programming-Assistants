#lang racket

(define (lexicographically-smallest-beautiful-string s k)
  (define n (string-length s))
  (define s-vec (string->vector s))

  (define (get-char-code-at idx current-vec)
    (if (and (>= idx 0) (< idx n))
        (char->integer (vector-ref current-vec idx))
        -1)) ; Sentinel for non-existent character code

  (for/first ([i (in-range (- n 1) -1 -1)]) ; Iterate i from n-1 down to 0
    (define current-char-code (char->integer (vector-ref s-vec i)))

    (for/first ([char-code (in-range (+ current-char-code 1) (+ (char->integer #\a) k))]) ; Try characters greater than current s[i]
      (define new-char (integer->char char-code))

      ; Check if new-char is valid at position i with respect to s[0...i-1]
      (define prev1-char-code (get-char-code-at (- i 1) s-vec))
      (define prev2-char-code (get-char-code-at (- i 2) s-vec))

      (when (and (!= char-code prev1-char-code)
                 (!= char-code prev2-char-code))

        ; Create a temporary vector for modifications
        (define temp-s-vec (vector-copy s-vec))
        (vector-set! temp-s-vec i new-char)

        ; Helper function to fill the suffix from start-j to n-1
        (define (fill-suffix-from-j start-j)
          (for/and ([j (in-range start-j n)]) ; for/and returns #f if any iteration returns #f
            (define found-char-for-j
              (for/first ([fill-char-code (in-range (char->integer #\a) (+ (char->integer #\a) k))])
                (define fill-char (integer->char fill-char-code))

                ; Check if fill-char is valid at position j with respect to temp-s-vec[0...j-1]
                (define fill-prev1-char-code (get-char-code-at (- j 1) temp-s-vec))
                (define fill-prev2-char-code (get-char-code-at (- j 2) temp-s-vec))

                (when (and (!= fill-char-code fill-prev1-char-code)
                           (!= fill-char-code fill-prev2-char-code))
                  (vector-set! temp-s-vec j fill-char)
                  #t) ; Return #t if a character is found and successfully set
                ))
            found-char-for-j ; This is #t if char found for 'j', #f otherwise. for/and will stop if #f.
            ))

        (when (fill-suffix-from-j (+ i 1))
          (vector->string temp-s-vec)) ; Return the resulting string
      )
    "") ; Default value for the char-code loop (if no valid char-code found for current i)
  "") ; Default value for the i loop (if no such string found)
)