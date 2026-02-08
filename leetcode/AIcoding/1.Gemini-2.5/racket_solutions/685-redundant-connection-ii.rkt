#lang racket

(define (find-redundant-directed-connection edges)
  (define max-node-id 0)
  (for-each (lambda (edge)
              (set! max-node-id (max max-node-id (car edge)))
              (set! max-node-id (max max-node-id (cadr edge))))
            edges)

  (define dsu-parent (make-vector (+ max-node-id 1) 0))
  (define dsu-rank (make-vector (+ max-node-id 1) 0))

  (define (dsu-make-set i)
    (vector-set! dsu-parent i i)
    (vector-set! dsu-rank i 0))

  (define (dsu-find i)
    (if (= (vector-ref dsu-parent i) i)
        i
        (let ([root (dsu-find (vector-ref dsu-parent i))])
          (vector-set! dsu-parent i root)
          root)))

  (define (dsu-union i j)
    (let ([root-i (dsu-find i)]
          [root-j (dsu-find j)])
      (unless (= root-i root-j)
        (let ([rank-i (vector-ref dsu-rank root-i)]
              [rank-j (vector-ref dsu-rank root-j)])
          (cond
            ((> rank-i rank-j) (vector-set! dsu-parent root-j root-i))
            ((< rank-i rank-j) (vector-set! dsu-parent root-i root-j))
            (else
             (vector-set! dsu-parent root-j root-i)
             (vector-set! dsu-rank root-i (+ rank-i 1))))))
      (= root-i root-j)))

  (define (has-cycle? edges-list)
    (for ([i (in-range 1 (+ max-node-id 1))]) (dsu-make-set i))
    (for/fold ([cycle-found? #f]) ([edge edges-list])
      (let ([u (car edge)]
            [v (cadr edge)])
        (if (dsu-union u v)
            #t
            cycle-found?))))

  (define in-degree (make-vector (+ max-node-id 1) 0))
  (define parent-map (make-vector (+ max-node-id 1) 0))
  (define candidate1 '())
  (define candidate2 '())

  (for-each (lambda (edge)
              (let ([u (car edge)]
                    [v (cadr edge)])
                (vector-set! in-degree v (+ (vector-ref in-degree v) 1))
                (when (= (vector-ref in-degree v) 2)
                  (set! candidate2 edge)
                  (set! candidate1 (list (vector-ref parent-map v) v)))
                (vector-set! parent-map v u)))
            edges)

  (if (not (empty? candidate2))
      (begin
        (define edges-without-candidate2 (filter (lambda (e) (not (equal? e candidate2))) edges))
        (if (has-cycle? edges-without-candidate2)
            candidate1
            candidate2))
      (begin
        (for ([i (in-range 1 (+ max-node-id 1))]) (dsu-make-set i))
        (for/first ([edge edges])
          (let ([u (car edge)]
                [v (cadr edge)])
            (when (dsu-union u v)
              edge))))))