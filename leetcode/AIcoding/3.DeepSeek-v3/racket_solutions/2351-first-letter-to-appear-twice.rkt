(define/contract (repeated-character s)
  (-> string? char?)
  (let loop ([chars (string->list s)]
             [seen (make-hash)])
    (cond
      [(null? chars) #\0] ; according to problem constraints, this case won't occur
      [(hash-has-key? seen (car chars)) (car chars)]
      [else (hash-set! seen (car chars) #t)
            (loop (cdr chars) seen)])))