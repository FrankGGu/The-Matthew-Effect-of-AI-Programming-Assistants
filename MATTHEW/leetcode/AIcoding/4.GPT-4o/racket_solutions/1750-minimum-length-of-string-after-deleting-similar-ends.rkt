(define (minimum-length s)
  (define len (string-length s))
  (define (trim s)
    (if (or (zero? (string-length s)) (equal? (string-ref s 0) (string-ref s (sub1 (string-length s)))))
        (substring s 1 (sub1 (string-length s)))
        s))
  (define trimmed (trim (trim s)))
  (if (string=? trimmed "")
      0
      (string-length trimmed)))

(minimum-length "ca") ; example usage