(define (min-cost-to-reach-destination max-time n passing-fees highways)
  (define adj (make-vector n null))
  (for-each (lambda (h)
              (let ([u (car h)] [v (cadr h)] [time (caddr h)])
                (vector-set! adj u (cons (list v time) (vector-ref adj u)))
                (vector-set! adj v (cons (list u time) (vector-ref adj v)))))
            highways)

  (define dp (make-vector n (make-vector (+ max-time 1) +inf.0)))
  (vector-set! (vector-ref dp 0) 0 (vector-ref passing-fees 0))

  (define (pq-empty? pq) (null? pq))
  (define (pq-peek pq) (car pq))
  (define (pq-pop! pq) (cdr pq))
  (define (pq-push! pq cost node time)
    (let loop ([p pq])
      (cond
        [(null? p) (list (list cost node time))]
        [(< cost (car (car p))) (cons (list cost node time) p)]
        [else (cons (car p) (loop (cdr p)))])))

  (let loop ([pq (list (list (vector-ref passing-fees 0) 0 0))])
    (if (pq-empty? pq)
        -1
        (let* ([curr (pq-peek pq)]
               [cost (car curr)]
               [node (cadr curr)]
               [time (caddr curr)])

          (if (= node (- n 1))
              cost
              (let ([new-pq (pq-pop! pq)])
                (for-each (lambda (neighbor)
                            (let ([next-node (car neighbor)]
                                  [travel-time (cadr neighbor)])
                              (let ([new-time (+ time travel-time)])
                                (when (and (<= new-time max-time)
                                           (< (vector-ref (vector-ref dp next-node) new-time)
                                              (+ cost (vector-ref passing-fees next-node))))
                                  (void))
                                (unless (and (<= new-time max-time)
                                             (>= (vector-ref (vector-ref dp next-node) new-time)
                                                 (+ cost (vector-ref passing-fees next-node)))))
                                  (vector-set! (vector-ref dp next-node) new-time (+ cost (vector-ref passing-fees next-node)))
                                  (set! new-pq (pq-push! new-pq (+ cost (vector-ref passing-fees next-node)) next-node new-time)))))
                          (vector-ref adj node))
                (loop new-pq)))))))