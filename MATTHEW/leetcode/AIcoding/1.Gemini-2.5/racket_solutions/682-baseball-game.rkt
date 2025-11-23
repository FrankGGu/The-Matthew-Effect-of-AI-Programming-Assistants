(define (calPoints ops)
  (let ((final-scores
         (foldl (lambda (op scores)
                  (cond
                    ((string=? op "+")
                     (let ((s1 (car scores))
                           (s2 (cadr scores)))
                       (cons (+ s1 s2) scores)))
                    ((string=? op "D")
                     (cons (* 2 (car scores)) scores))
                    ((string=? op "C")
                     (cdr scores))
                    (else ; Must be a number
                     (cons (string->number op) scores))))
                '()
                ops)))
    (apply + final-scores)))