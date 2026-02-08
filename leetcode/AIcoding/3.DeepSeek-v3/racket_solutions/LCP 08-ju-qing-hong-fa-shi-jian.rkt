(define (get-trigger-time increase requirements)
  (let loop ([day 0]
             [c 0]
             [r 0]
             [h 0]
             [i 0]
             [reqs requirements]
             [res '()])
    (cond
      [(null? reqs) (reverse res)]
      [else
       (let* ([req (car reqs)]
              [req-c (car req)]
              [req-r (cadr req)]
              [req-h (caddr req)]
              [new-c (+ c (if (< day (length increase)) (car (list-ref increase day)) 0))]
              [new-r (+ r (if (< day (length increase)) (cadr (list-ref increase day)) 0))]
              [new-h (+ h (if (< day (length increase)) (caddr (list-ref increase day)) 0))]
              [met (and (>= new-c req-c) (>= new-r req-r) (>= new-h req-h))])
         (if met
             (loop day new-c new-r new-h (add1 i) (cdr reqs) (cons day res))
             (loop (add1 day) new-c new-r new-h i reqs res)))])))