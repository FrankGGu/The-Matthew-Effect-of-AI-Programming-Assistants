(define (minimum-moves-to-convert-string s)
  (define (helper i count)
    (if (>= i (string-length s))
        count
        (let ((c (string-ref s i)))
          (if (char=? c #\A)
              (helper (+ i 1) count)
              (helper (+ i 3) (+ count 1))))))
  (helper 0 0))