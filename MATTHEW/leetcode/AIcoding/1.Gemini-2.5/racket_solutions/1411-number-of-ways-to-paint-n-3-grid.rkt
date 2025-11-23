(define (num-ways n)
  (define MOD 1000000007)

  ; dp_aba[k] represents the number of ways to paint k columns
  ; such that the k-th column has a "ABA" type pattern (e.g., 121, 212).
  ; dp_abc[k] represents the number of ways to paint k columns
  ; such that the k-th column has an "ABC" type pattern (e.g., 123, 213).

  ; Base case for n = 1:
  ; There are 6 patterns of type ABA (121, 131, 212, 232, 313, 323)
  ; There are 6 patterns of type ABC (123, 132, 213, 231, 312, 321)
  (define dp-aba-prev 6)
  (define dp-abc-prev 6)

  ; If n is 1, the total ways are the sum of base cases.
  (if (= n 1)
      (+ dp-aba-prev dp-abc-prev)
      ; Iterate from k=2 up to n
      (let loop ((k 2)
                 (aba-prev dp-aba-prev)
                 (abc-prev dp-abc-prev))
        (if (> k n)
            ; Once k exceeds n, we have calculated the values for n columns.
            ; Return the sum of ABA and ABC patterns for n columns.
            (modulo (+ aba-prev abc-prev) MOD)
            ; Calculate dp_aba[k] and dp_abc[k] based on (k-1) values
            (let* ((aba-curr (modulo (+ (* 3 aba-prev) (* 2 abc-prev)) MOD))
                   (abc-curr (modulo (+ (* 2 aba-prev) (* 2 abc-prev)) MOD)))
              ; Continue to the next column
              (loop (+ k 1) aba-curr abc-curr))))))