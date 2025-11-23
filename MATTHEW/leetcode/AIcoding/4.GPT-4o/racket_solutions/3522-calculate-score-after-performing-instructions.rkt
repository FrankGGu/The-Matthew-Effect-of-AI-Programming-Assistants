(define (calculateScore instructions)
  (define (process-instructions ins)
    (define score 0)
    (define history '())
    (for-each (lambda (i)
                (cond
                  [(equal? i "+")
                   (let ([last (car history)]
                         [second-last (cadr history)])
                     (set! score (+ score (+ last second-last)))
                     (set! history (cons (+ last second-last) history)))]
                  [(equal? i "D")
                   (let ([last (car history)])
                     (set! score (+ score (* 2 last)))
                     (set! history (cons (* 2 last) history)))]
                  [(equal? i "C")
                   (let ([last (car history)])
                     (set! score (- score last))
                     (set! history (cdr history)))]
                  [else
                   (let ([num (string->number i)])
                     (set! score (+ score num))
                     (set! history (cons num history)))])
                )
              ins)
    score)
  (process-instructions instructions))

(calculateScore '("5" "2" "C" "D" "+"))