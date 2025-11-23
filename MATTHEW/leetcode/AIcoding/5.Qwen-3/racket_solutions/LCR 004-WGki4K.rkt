(define (single-number nums)
  (let ([seen (make-hash)]
        [seen-twice (make-hash)])
    (for-each
     (lambda (num)
       (if (hash-has-key? seen num)
           (begin
             (hash-set! seen-twice num #t)
             (hash-remove! seen num))
           (begin
             (hash-set! seen num #t)
             (when (hash-has-key? seen-twice num)
               (hash-remove! seen-twice num)))))
     nums)
    (hash-key (hash-ref seen #f))))