(define (complex-number-multiply num1 num2)
  ;; Helper to parse a complex number string "a+bi" into a list (a b)
  (define (parse-complex s)
    (let* ([i-idx (string-index s #\i)]
           ;; Find the separator ('+' or '-') that divides real and imaginary parts.
           ;; This separator will not be the very first character of the string
           ;; if the real part is negative.
           [sep-idx (let loop ([k 1]) ; Start searching from index 1
                      (cond
                        [(>= k i-idx)
                         (error "Invalid complex number format: no separator found before 'i'")]
                        [(or (char=? (string-ref s k) #\+)
                             (char=? (string-ref s k) #\-))
                         k]
                        [else (loop (+ k 1))]))]
           [real-str (substring s 0 sep-idx)]
           [imag-str (substring s (+ sep-idx 1) i-idx)]) ; +1 to skip the separator character
      (list (string->number real-str) (string->number imag-str))))

  (let* ([c1 (parse-complex num1)]
         [c2 (parse-complex num2)]
         [r1 (car c1)]
         [i1 (cadr c1)]
         [r2 (car c2)]
         [i2 (cadr c2)]
         ;; (a + bi)(c + di) = (ac - bd) + (ad + bc)i
         [res-r (- (* r1 r2) (* i1 i2))]
         [res-i (+ (* r1 i2) (* i1 r2))])
    (format "~a+~ai" res-r res-i)))