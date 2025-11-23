(define (max-power s)
  (define (helper i max-count current-char count)
    (if (= i (string-length s))
        max-count
        (let ((char (string-ref s i)))
          (if (= char current-char)
              (helper (+ i 1) max-count char (+ count 1))
              (helper (+ i 1) (max max-count count) char 1)))))
  (if (string=? s "")
      0
      (helper 0 1 (string-ref s 0) 1)))