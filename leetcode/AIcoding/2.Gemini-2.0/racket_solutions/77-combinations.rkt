(define (combine n k)
  (define (helper start count)
    (cond
      [(= count 0) '(())]
      [(<= start n)
       (append
        (map (lambda (x) (cons start x)) (helper (+ start 1) (- count 1)))
        (helper (+ start 1) count))]
      [else '()]))
  (helper 1 k))