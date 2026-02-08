(define (replaceDigits s)
  (define (replace-char c d)
    (if (char? d)
        (integer->char (+ (char->integer c) (char->integer d)))
        c))
  (define (helper str index)
    (if (>= index (string-length str))
        str
        (let ((current (string-ref str index)))
          (if (char-numeric? current)
              (let ((prev (string-ref str (- index 1))))
                (helper (string-replace str index (replace-char prev current)) (+ index 1)))
              (helper str (+ index 1))))))
  (helper s 1))

(replaceDigits "a1c1e1") ; Example usage