(define (find-second-minimum-value root)
  (define min1 (car root))
  (define ans (list #inf))

  (define (dfs node)
    (cond
      [(null? node) #f]
      [(= (car node) min1)
       (dfs (cadr node))
       (dfs (caddr node))]
      [(< (car node) (car ans))
       (set! ans (list (car node)))]))

  (dfs root)
  (if (= (car ans) #inf) -1 (car ans)))