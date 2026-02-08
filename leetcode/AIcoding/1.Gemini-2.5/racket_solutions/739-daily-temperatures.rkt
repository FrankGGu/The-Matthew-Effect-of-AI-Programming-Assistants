(define (daily-temperatures temperatures)
  (define n (length temperatures))
  (define results (make-vector n 0))
  (define stack '())

  (for ([temp (in-list temperatures)]
        [i (in-naturals)])
    (let loop ()
      (when (and (not (empty? stack))
                 (< (cdr (car stack)) temp))
        (let* ([top-pair (car stack)]
               [prev-index (car top-pair)])
          (vector-set! results prev-index (- i prev-index))
          (set! stack (cdr stack))
          (loop))))
    (set! stack (cons (cons i temp) stack)))

  (vector->list results))