#lang racket

(define (count-texts pressedKeys)
  (define n (string-length pressedKeys))
  (define MOD 1000000007)

  ;; dp[i] will store the number of ways to decode the prefix of length i (pressedKeys[0...i-1])
  ;; dp[0] = 1 (empty string has one way to decode)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)

  (for ([i (in-range 1 (+ n 1))])
    (define current-char (string-ref pressedKeys (- i 1)))
    (define ways 0)

    ;; Helper function to get the number of options for a given number of presses
    (define (get-options char num-presses)
      (case char
        [(#\2 #\3 #\4 #\5 #\6 #\8) ; 3-letter keys
         (case num-presses
           [1 3]
           [2 3]
           [3 2]
           [else 0])] ; Should not happen for 3-letter keys beyond 3 presses
        [(#\7 #\9) ; 4-letter keys
         (case num-presses
           [1 4]
           [2 3]
           [3 2]
           [4 1]
           [else 0])] ; Should not happen for 4-letter keys beyond 4 presses
        [else 0])) ; Invalid character

    ;; Option 1: Decode the last character as a single press.
    ;; This contributes (dp[i-1] * options_for_1_press) ways.
    (set! ways (+ ways (* (vector-ref dp (- i 1)) (get-options current-char 1))))

    ;; Option 2: Decode the last two identical characters as two presses.
    ;; This is possible if i >= 2 and the last two characters are the same.
    ;; This contributes (dp[i-2] * options_for_2_press) ways.
    (when (and (>= i 2)
               (char=? current-char (string-ref pressedKeys (- i 2))))
      (set! ways (+ ways (* (vector-ref dp (- i 2)) (get-options current-char 2)))))

    ;; Option 3: Decode the last three identical characters as three presses.
    ;; This is possible if i >= 3 and the last three characters are the same.
    ;; This contributes (dp[i-3] * options_for_3_press) ways.
    (when (and (>= i 3)
               (char=? current-char (string-ref pressedKeys (- i 2)))
               (char=? current-char (string-ref pressedKeys (- i 3))))
      (set! ways (+ ways (* (vector-ref dp (- i 3)) (get-options current-char 3)))))

    ;; Option 4: Decode the last four identical characters as four presses.
    ;; This is only possible for digits '7' and '9', and if i >= 4 and the last four characters are the same.
    ;; This contributes (dp[i-4] * options_for_4_press) ways.
    (when (and (>= i 4)
               (or (char=? current-char #\7) (char=? current-char #\9))
               (char=? current-char (string-ref pressedKeys (- i 2)))
               (char=? current-char (string-ref pressedKeys (- i 3)))
               (char=? current-char (string-ref pressedKeys (- i 4))))
      (set! ways (+ ways (* (vector-ref dp (- i 4)) (get-options current-char 4)))))

    (vector-set! dp i (modulo ways MOD)))

  (vector-ref dp n))