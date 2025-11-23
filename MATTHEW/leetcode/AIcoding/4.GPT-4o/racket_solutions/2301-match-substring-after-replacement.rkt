(define (match-substring-after-replacement s sub s2)
  (define (replace s)
    (string-append (substring s 0 (string-length s2)) (substring s (string-length s2))))
  (define (substring-match? s sub)
    (let loop ((i 0))
      (if (>= i (string-length s))
          #f
          (if (equal? (substring s i (+ i (string-length sub))) sub)
              #t
              (loop (+ i 1))))))
  (define (check-replacement s2)
    (let ((replaced (replace s2)))
      (substring-match? s replaced)))
  (check-replacement s))

(define (isMatch s sub s2)
  (match-substring-after-replacement s sub s2))