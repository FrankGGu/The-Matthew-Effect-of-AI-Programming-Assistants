(define (repeated-substring-pattern s)
  (let ((t (string-append s s)))
    (and (> (string-length s) 0)
         (not (string=? s (substring t 1 (sub1 (string-length t))))))))