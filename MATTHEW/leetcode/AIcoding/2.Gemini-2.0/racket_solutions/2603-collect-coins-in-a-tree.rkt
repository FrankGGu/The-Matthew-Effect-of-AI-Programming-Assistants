(define (collect-coins edges coins)
  (let* ([n (length coins)]
         [adj (make-vector n '())]
         [degree (make-vector n 0)]
         [visited (make-vector n #f)])
    (for-each (lambda (edge)
                (let ([u (first edge)]
                      [v (second edge)])
                  (vector-set! adj u (cons v (vector-ref adj u)))
                  (vector-set! adj v (cons u (vector-ref adj v)))
                  (vector-set! degree u (+ 1 (vector-ref degree u)))
                  (vector-set! degree v (+ 1 (vector-ref degree v)))))
              edges)

    (let loop1 ([q (list)])
      (if (empty? q)
          (void)
          (let* ([u (first q)]
                 [new-q (rest q)])
            (if (and (= (vector-ref degree u) 1) (not (vector-ref coins u)))
                (begin
                  (vector-set! visited u #t)
                  (vector-set! degree u 0)
                  (for-each (lambda (v)
                              (if (> (vector-ref degree v) 0)
                                  (begin
                                    (vector-set! degree v (- (vector-ref degree v) 1))
                                    (if (= (vector-ref degree v) 1)
                                        (set! new-q (append new-q (list v)))))))
                            (vector-ref adj u))
                  (loop1 new-q))
                (loop1 new-q))))
    (let loop2 ([q (list)])
      (for/vector ([i (in-range n)])
        (when (and (not (vector-ref visited i)) (<= (vector-ref degree i) 1))
          (set! q (append q (list i)))))
      (if (empty? q)
          (void)
          (let* ([u (first q)]
                 [new-q (rest q)])
            (vector-set! visited u #t)
            (vector-set! degree u 0)
            (for-each (lambda (v)
                        (if (> (vector-ref degree v) 0)
                            (begin
                              (vector-set! degree v (- (vector-ref degree v) 1))
                              (if (= (vector-ref degree v) 1)
                                  (set! new-q (append new-q (list v)))))))
                      (vector-ref adj u))
            (loop2 new-q))))

    (let ([count (for/sum ([i (in-range n)])
                  (if (not (vector-ref visited i)) 1 0))])
      (if (<= count 2)
          0
          (- (* 2 (- count 1)) (* 2))))))