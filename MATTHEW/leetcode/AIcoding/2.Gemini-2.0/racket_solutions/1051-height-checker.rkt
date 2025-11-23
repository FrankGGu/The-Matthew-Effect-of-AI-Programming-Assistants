(define (height-checker heights)
  (let* ([sorted-heights (sort heights <)])
    (length (filter (lambda (x) (not (equal? (list-ref heights x) (list-ref sorted-heights x)))) (range (length heights))))))