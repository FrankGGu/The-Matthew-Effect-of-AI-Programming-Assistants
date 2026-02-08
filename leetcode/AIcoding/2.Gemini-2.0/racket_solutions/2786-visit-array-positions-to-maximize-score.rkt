(define (maxScore nums x (k 0))
  (define (solve idx even-so-far score)
    (cond
      [(>= idx (length nums)) score]
      [else
       (let* ([num (list-ref nums idx)]
              [is-even? (even? num)]
              [new-score (+ score num (if (equal? is-even? even-so-far) 0 x))])
         (max (solve (+ idx 1) is-even? new-score)
              (solve (+ idx 1) even-so-far score))))))
  (solve 1 (even? (list-ref nums 0)) (list-ref nums 0)))