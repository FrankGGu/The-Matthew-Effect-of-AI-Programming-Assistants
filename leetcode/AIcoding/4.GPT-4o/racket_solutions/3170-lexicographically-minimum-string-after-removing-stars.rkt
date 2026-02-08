(define (removeStars s)
  (define (helper s)
    (if (string-null? s)
        ""
        (let ((last-char (string-ref s (- (string-length s) 1))))
          (if (char=? last-char #\*)
              (helper (substring s 0 (- (string-length s) 1)))
              (string-append (helper (substring s 0 (- (string-length s) 1))) (string last-char))))))
  (helper s))

(define (removeStarsWrapper s)
  (removeStars s))