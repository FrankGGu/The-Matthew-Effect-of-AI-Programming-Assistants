(define (findSequence strings)
  (define (helper seq)
    (if (null? seq)
        '()
        (cons (first seq) (helper (rest seq)))))
  (helper strings))

(define (findTheSequence strings)
  (findSequence strings))