(define (minimumDeletions s)
  (let loop ((i 0) (a 0) (b 0))
    (cond
      ((= i (string-length s)) (+ a b))
      (else
       (let ((char (string-ref s i)))
         (cond
           ((char=? char #\a) (loop (+ i 1) a (+ b 1)))
           ((char=? char #\b) (loop (+ i 1) (+ a 1) b))
           (else (loop (+ i 1) a b))))))))

(define (min-deletions s)
  (minimumDeletions s))