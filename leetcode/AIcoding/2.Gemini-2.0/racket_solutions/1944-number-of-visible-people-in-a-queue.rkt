(define (visible-people queue)
  (define n (length queue))
  (define result (make-vector n 0))
  (define stack '())
  (for/list ([i (in-range (sub1 n) -1 -1)])
    (let loop ()
      (cond
        [(empty? stack)
         (vector-set! result i 0)
         (set! stack (cons (list (list-ref queue i) i) stack))]
        [else
         (let ([top (car stack)])
           (let ([top-val (car (car stack))])
             (cond
               [(= (list-ref queue i) top-val)
                (vector-set! result i 1)
                (set! stack (cons (list (list-ref queue i) i) stack))]
               [(< (list-ref queue i) top-val)
                (vector-set! result i (add1 (vector-ref result i)))
                (set! stack (cons (list (list-ref queue i) i) stack))]
               [else
                (set! stack (cdr stack))
                (vector-set! result i (add1 (vector-ref result i)))
                (when (empty? stack)
                  (vector-set! result i (sub1 (vector-ref result i))))
                (loop)]))))]))
    #f)
  (vector->list result))