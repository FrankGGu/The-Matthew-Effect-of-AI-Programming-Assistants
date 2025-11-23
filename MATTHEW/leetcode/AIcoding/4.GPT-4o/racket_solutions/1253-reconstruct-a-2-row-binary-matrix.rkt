(define (reconstructMatrix upper lower colsum)
  (define total-sum (apply + colsum))
  (define upper-remaining upper)
  (define lower-remaining lower)
  (define matrix '())

  (for-each (lambda (sum)
              (cond
                ((= sum 2)
                 (if (and (> upper-remaining 0) (> lower-remaining 0))
                     (begin
                       (set! upper-remaining (- upper-remaining 1))
                       (set! lower-remaining (- lower-remaining 1))
                       (set! matrix (cons (list 1 1) matrix))
                     )
                     (begin
                       (set! matrix (cons (list 0 0) matrix))
                     )))
                ((= sum 1)
                 (if (> upper-remaining 0)
                     (begin
                       (set! upper-remaining (- upper-remaining 1))
                       (set! matrix (cons (list 1 0) matrix))
                     )
                     (begin
                       (set! lower-remaining (- lower-remaining 1))
                       (set! matrix (cons (list 0 1) matrix))
                     )))
                (else
                 (set! matrix (cons (list 0 0) matrix)))))
            colsum)

  (if (and (= upper-remaining 0) (= lower-remaining 0))
      (reverse matrix)
      '()))