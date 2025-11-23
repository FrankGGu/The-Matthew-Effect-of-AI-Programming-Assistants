(define (valid-number s)
  (let* ([n (string-length s)]
         [state 0] ; 0: initial/leading spaces, 1: sign, 2: integer, 3: dot_after_int, 4: fraction, 5: dot_only, 6: 'e', 7: sign_after_e, 8: exponent, 9: trailing_spaces
         [has-digits #f]
         [has-exponent-digits #f])

    (for ([i (in-range n)])
      (let* ([char (string-ref s i)]
             [next-state -1])

        (set! next-state
              (case state
                [0 ; Initial state or leading spaces
                 (cond
                   [(char=? char #\space) 0]
                   [(or (char=? char #\+) (char=? char #\-)) 1]
                   [(char-numeric? char) 2]
                   [(char=? char #\.) 5]
                   [else -1])]
                [1 ; Sign encountered
                 (cond
                   [(char-numeric? char) 2]
                   [(char=? char #\.) 5]
                   [else -1])]
                [2 ; Integer part (e.g., "123")
                 (cond
                   [(char-numeric? char) 2]
                   [(char=? char #\.) 3]
                   [(or (char=? char #\e) (char=? char #\E)) 6]
                   [(char=? char #\space) 9]
                   [else -1])]
                [3 ; Dot after integer (e.g., "123.")
                 (cond
                   [(char-numeric? char) 4]
                   [(or (char=? char #\e) (char=? char #\E)) 6]
                   [(char=? char #\space) 9]
                   [else -1])]
                [4 ; Fractional part (e.g., "123.45" or ".45")
                 (cond
                   [(char-numeric? char) 4]
                   [(or (char=? char #\e) (char=? char #\E)) 6]
                   [(char=? char #\space) 9]
                   [else -1])]
                [5 ; Dot only (e.g., ".5")
                 (cond
                   [(char-numeric? char) 4]
                   [else -1])]
                [6 ; 'e' or 'E' encountered (e.g., "123e")
                 (cond
                   [(or (char=? char #\+) (char=? char #\-)) 7]
                   [(char-numeric? char) 8]
                   [else -1])]
                [7 ; Sign after 'e'/'E' (e.g., "123e+")
                 (cond
                   [(char-numeric? char) 8]
                   [else -1])]
                [8 ; Exponent part (e.g., "123e+12")
                 (cond
                   [(char-numeric? char) 8]
                   [(char=? char #\space) 9]
                   [else -1])]
                [9 ; Trailing spaces (e.g., "123 ")
                 (cond
                   [(char=? char #\space) 9]
                   [else -1])]
                [else -1]))

        (when (= next-state -1)
          (set! state -1)
          (break))

        (set! state next-state)

        (when (or (= state 2) (= state 3) (= state 4))
          (set! has-digits #t))
        (when (= state 8)
          (set! has-exponent-digits #t))))

    (and (not (= state -1))
         has-digits
         (or (not (or (= state 6) (= state 7)))
             has-exponent-digits))))