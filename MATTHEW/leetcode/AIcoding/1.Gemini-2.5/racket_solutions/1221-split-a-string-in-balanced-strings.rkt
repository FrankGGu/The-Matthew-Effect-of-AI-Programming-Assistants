(define (balanced-string-split s)
  (let loop ((chars (string->list s))
             (balance 0)
             (count 0))
    (cond
      ((empty? chars)
       count)
      (else
       (let* ((char (car chars))
              (new-balance (cond
                             ((char=? char #\L) (+ balance 1))
                             ((char=? char #\R) (- balance 1))
                             (else balance))) ; Should not happen for this problem
              (new-count (if (= new-balance 0) (+ count 1) count)))
         (loop (cdr chars) new-balance new-count))))))