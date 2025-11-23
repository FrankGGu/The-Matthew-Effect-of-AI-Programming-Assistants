(define (is-valid-serialization preorder)
  (define (helper lst slots)
    (cond
      [(empty? lst) (= slots 0)]
      [else
       (let ([first (car lst)]
             [rest (cdr lst)])
         (cond
           [(= slots 0) #f]
           [(equal? first "#") (helper rest (- slots 1))]
           [else (helper rest (+ slots 1))]
           ))]))

  (let* ([nodes (string-split preorder ",")]
         [slots 1])
    (helper nodes slots)))