(define (max-depth s)
  (let loop ((chars (string->list s))
             (current-depth 0)
             (max-depth 0))
    (cond
      ((null? chars) max-depth)
      ((char=? (car chars) #\()
       (loop (cdr chars)
             (+ current-depth 1)
             (max current-depth max-depth)))
      ((char=? (car chars) #\))
       (loop (cdr chars)
             (- current-depth 1)
             max-depth))
      (else
       (loop (cdr chars)
             current-depth
             max-depth)))))