(define (min-length-substring s)
  (let loop ((s s) (min-length +inf.0) (last-char #f) (count 0))
    (cond
      ((null? s) (if (= count 0) 0 min-length))
      ((equal? (car s) last-char)
       (loop (cdr s) (min min-length (+ count 1)) last-char (+ count 1)))
      (else
       (loop (cdr s) (min min-length count) (car s) 1)))))

(define (get-min-length-substring s)
  (min-length-substring (string->list s)))