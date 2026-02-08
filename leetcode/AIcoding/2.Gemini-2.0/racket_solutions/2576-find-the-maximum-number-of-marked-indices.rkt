(define (max-marked-indices nums)
  (define sorted-nums (sort nums <))
  (define n (length sorted-nums))
  (define (helper left right count)
    (cond
      [(>= left (/ n 2)) count]
      [(>= right n) count]
      [(<= (list-ref sorted-nums left) (/ (list-ref sorted-nums right) 2))
       (helper (+ left 1) (+ right 1) (+ count 2))]
      [else (helper left (+ right 1) count)]))
  (helper 0 (/ n 2) 0))