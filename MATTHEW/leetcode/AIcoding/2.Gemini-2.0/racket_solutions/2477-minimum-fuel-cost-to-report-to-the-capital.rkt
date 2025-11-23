(define (minimum-fuel-cost roads seats)
  (define n (+ 1 (length (apply append roads))))
  (define adj (make-vector n '()))
  (for-each (lambda (r)
              (let ((u (car r)) (v (cadr r)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            roads)

  (define fuel (box 0))

  (define (dfs node parent)
    (let loop ((neighbors (vector-ref adj node)) (people 1))
      (cond
        ((null? neighbors) people)
        (else
         (let ((neighbor (car neighbors)))
           (if (= neighbor parent)
               (loop (cdr neighbors) people)
               (let ((child-people (dfs neighbor node)))
                 (set-box! fuel (+ (unbox fuel) (ceiling (/ child-people seats))))
                 (loop (cdr neighbors) (+ people child-people))))))))
  )

  (dfs 0 -1)
  (unbox fuel)
)