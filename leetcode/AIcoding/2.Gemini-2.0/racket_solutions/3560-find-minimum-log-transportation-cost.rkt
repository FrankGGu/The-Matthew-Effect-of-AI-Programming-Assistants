(define (min-cost-flow graph source sink capacity cost)
  (define n (vector-length graph))
  (define flow (make-vector n (make-vector n 0)))
  (define total-cost 0)

  (define (augment)
    (define dist (make-vector n +inf.0))
    (define prev (make-vector n #f))
    (vector-set! dist source 0)

    (define (relax u)
      (for/list ([v (in-range n)]
                 #:when (and (> (vector-ref capacity u v) (vector-ref (vector-ref flow u) v))
                             (< (+ (vector-ref dist u) (vector-ref (vector-ref cost u) v)) (vector-ref dist v))))
        (begin
          (vector-set! dist v (+ (vector-ref dist u) (vector-ref (vector-ref cost u) v)))
          (vector-set! prev v u))))

    (for/list ([i (in-range n)]
               [u (in-range n)])
      (relax u))

    (if (equal? (vector-ref dist sink) +inf.0)
        #f
        (let loop ([curr sink] [min-flow +inf.0])
          (if (equal? curr source)
              (begin
                (let loop2 ([curr sink])
                  (if (equal? curr source)
                      #t
                      (let ([prev-node (vector-ref prev curr)])
                        (vector-set! (vector-ref flow prev-node curr) (+ (vector-ref (vector-ref flow prev-node curr)) min-flow))
                        (vector-set! (vector-ref flow curr prev-node) (- (vector-ref (vector-ref flow curr prev-node)) min-flow))
                        (loop2 prev-node)))))
              (let ([prev-node (vector-ref prev curr)])
                (loop prev-node (min min-flow (- (vector-ref capacity prev-node curr) (vector-ref (vector-ref flow prev-node curr))))))))))

  (let loop ()
    (if (augment)
        (loop)
        #t))

  (for/sum ([u (in-range n)]
            [v (in-range n)])
    (* (vector-ref (vector-ref flow u) v) (vector-ref (vector-ref cost u) v))))

(define (min-cost graph logs)
  (let* ([n (length graph)]
         [source 0]
         [sink (- n 1)]
         [capacity (make-vector n (make-vector n 0))]
         [cost (make-vector n (make-vector n 0))])

    (for/list ([i (in-range n)]
               [j (in-range n)])
      (vector-set! (vector-ref capacity i) j (cdr (assoc j (list-ref graph i)))))

    (for/list ([i (in-range n)]
               [j (in-range n)])
      (vector-set! (vector-ref cost i) j (car (assoc j (list-ref graph i)))))

    (vector-set! (vector-ref capacity source) 1 +inf.0)
    (vector-set! (vector-ref cost source) 1 0)

    (for/list ([i (in-range 2 (- n 1))])
        (vector-set! (vector-ref capacity (+ i 1)) (+ i 2) +inf.0)
        (vector-set! (vector-ref cost (+ i 1)) (+ i 2) 0))

    (min-cost-flow capacity source sink capacity cost)))