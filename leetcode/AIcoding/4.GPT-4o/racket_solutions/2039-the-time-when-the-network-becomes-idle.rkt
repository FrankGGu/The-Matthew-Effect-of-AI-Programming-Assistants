(define (networkBecomesIdle edges patience)
  (define n (add1 (length edges)))
  (define graph (make-vector n))

  (for ([i (in-range (length edges))])
    (for ([j (in-list (vector-ref edges i))])
      (vector-set! graph (add1 i) (cons (add1 j) (vector-ref graph (add1 i))))))

  (define (bfs)
    (define queue (list 1))
    (define dist (make-vector n -1))
    (vector-set! dist 1 0)
    (define idx 0)

    (while (not (null? queue))
      (define curr (car queue))
      (set! queue (cdr queue))
      (for ([neighbor (in-list (vector-ref graph curr))])
        (when (= (vector-ref dist neighbor) -1)
          (vector-set! dist neighbor (+ (vector-ref dist curr) 1))
          (set! queue (append queue (list neighbor))))))

    dist))

  (define dist (bfs))
  (define max-time 0)

  (for ([i (in-range 2 n)])
    (define time (if (= (vector-ref dist i) -1) 0
                   (+ (* (vector-ref dist i) 2) (if (> (quotient (* (vector-ref dist i) 2) patience) 0)
                                                        (* (quotient (* (vector-ref dist i) 2) patience) patience)
                                                        0))))
    (set! max-time (max max-time time)))

  (+ max-time 1))