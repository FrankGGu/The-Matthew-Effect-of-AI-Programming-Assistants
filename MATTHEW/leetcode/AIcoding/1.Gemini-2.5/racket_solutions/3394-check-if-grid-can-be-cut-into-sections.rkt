#lang racket

(define (can-cut-grid grid-list)
  (define rows (length grid-list))
  (define cols (if (empty? grid-list) 0 (length (car grid-list))))

  (if (or (zero? rows) (zero? cols))
      #t
      (let* ([grid (list->vector (map list->vector grid-list))]
             [memo (make-hash)]
             [mono-memo (make-hash)])

        (define (is-monochromatic? r1 c1 r2 c2)
          (let ([key (list r1 c1 r2 c2)])
            (cond
              [(hash-has-key? mono-memo key) (hash-ref mono-memo key)]
              [else
               (let ([result
                      (if (or (> r1 r2) (> c1 c2))
                          #t
                          (let* ([val (vector-ref (vector-ref grid r1) c1)])
                            (for*/and ([r (range r1 (add1 r2))]
                                       [c (range c1 (add1 c2))])
                              (= (vector-ref (vector-ref grid r) c) val)))))]
                 (hash-set! mono-memo key result)
                 result)])))

        (define (solve r1 c1 r2 c2)
          (let ([key (list r1 c1 r2 c2)])
            (cond
              [(hash-has-key? memo key) (hash-ref memo key)]
              [else
               (let ([result
                      (cond
                        [(is-monochromatic? r1 c1 r2 c2) #t]
                        [else
                         (or (for/or ([r (range r1 r2)])
                               (and (solve r1 c1 r c2)
                                    (solve (add1 r) c1 r2 c2)))
                             (for/or ([c (range c1 c2)])
                               (and (solve r1 c1 r2 c)
                                    (solve r1 (add1 c) r2 c2)))))]
                      )])
                 (hash-set! memo key result)
                 result))])))

        (solve 0 0 (sub1 rows) (sub1 cols)))))