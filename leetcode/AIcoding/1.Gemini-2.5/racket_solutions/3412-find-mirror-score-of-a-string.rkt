(define (get-mirror-digit c)
  (case c
    ((#\0) #\0)
    ((#\1) #\1)
    ((#\8) #\8)
    ((#\6) #\9)
    ((#\9) #\6)
    (else #f)))

(define (find-mirror-score-of-string s)
  (let ((n (string-length s)))
    (for/sum ((i (in-range n)))
      (let* ((char-at-i (string-ref s i))
             (char-at-mirror-pos (string-ref s (- n 1 i)))
             (mirror-of-char-at-i (get-mirror-digit char-at-i)))
        (if (and mirror-of-char-at-i
                 (char=? mirror-of-char-at-i char-at-mirror-pos))
            1
            0)))))