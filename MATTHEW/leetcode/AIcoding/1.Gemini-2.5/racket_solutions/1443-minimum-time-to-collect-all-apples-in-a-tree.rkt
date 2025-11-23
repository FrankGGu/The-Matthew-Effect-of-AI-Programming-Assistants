(define (min-time-to-collect-apples n edges hasApple-list)
  (define hasApple (list->vector hasApple-list))

  (define adj (make-vector n (list)))
  (for-each
   (lambda (edge)
     (let ([u (car edge)]
           [v (cadr edge)])
       (vector-set! adj u (cons v (vector-ref adj u)))
       (vector-set! adj v (cons u (vector-ref adj v)))))
   edges)

  (define total-time 0)

  (define (dfs u parent)
    (define current-node-has-apple (vector-ref hasApple u))
    (define subtree-has-apple current-node-has-apple)

    (for-each
     (lambda (v)
       (when (not (= v parent))
         (when (dfs v u)
           (set! total-time (+ total-time 2))
           (set! subtree-has-apple #t))))
     (vector-ref adj u))
    subtree-has-apple)

  (dfs 0 -1)
  total-time)