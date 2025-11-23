(define (repeated-character s)
  (let loop ([chars (string->list s)] [seen (make-hash)])
    (cond
      [(null? chars) #f]
      [else
       (let ([c (car chars)])
         (if (hash-has-key? seen c)
             c
             (begin
               (hash-set! seen c #t)
               (loop (cdr chars) seen))))])))