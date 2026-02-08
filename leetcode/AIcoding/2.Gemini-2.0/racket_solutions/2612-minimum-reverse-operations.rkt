(define (minimum-reverse-operations n p banned k)
  (define banned-set (set banned))
  (define dist (make-vector n -1))
  (vector-set! dist p 0)

  (define (is-banned? x) (set-member? banned-set x))

  (define (bfs)
    (define q (list p))
    (define (process-q q)
      (cond
        [(null? q) #t]
        [else
         (let* ([curr (car q)]
                [parity (modulo curr 2)])
           (define (add-neighbor neighbor d)
             (cond
               [(and (>= neighbor 0) (< neighbor n) (vector-ref dist neighbor) eqv? -1 (not (is-banned? neighbor)))
                (vector-set! dist neighbor d)
                (set! q (append q (list neighbor)))
                #t]
               [else #f]))

           (for ([len (in-range 1 (+ 1 k))])
             (let ([neighbor (- (+ curr len -1) (- k len))])
               (add-neighbor neighbor (+ 1 (vector-ref dist curr)))))
           (process-q (cdr q))])))
    (process-q q))

  (bfs)
  (vector->list dist))