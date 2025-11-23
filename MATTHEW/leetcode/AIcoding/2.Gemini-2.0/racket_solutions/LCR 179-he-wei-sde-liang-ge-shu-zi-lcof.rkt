(define (two-sum prices target)
  (let loop ([prices prices] [seen (make-hash)])
    (cond
      [(null? prices) #f]
      [else
       (let ([current (car prices)]
             [complement (- target current)])
         (if (hash-has-key? seen complement)
             (list complement current)
             (begin
               (hash-set! seen current #t)
               (loop (cdr prices) seen))))])))