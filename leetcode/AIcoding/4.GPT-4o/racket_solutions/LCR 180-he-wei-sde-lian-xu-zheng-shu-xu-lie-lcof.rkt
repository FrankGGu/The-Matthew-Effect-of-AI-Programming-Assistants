(define (min-combine files)
  (define (combine files)
    (if (null? files)
        0
        (let* ([sorted (sort files <)]
               [first (car sorted)]
               [second (cadr sorted)]
               [combined (+ first second)])
          (+ combined (combine (cons combined (cddr sorted))))))
    )
  (combine files))

(define (minCost files)
  (min-combine files))