(define (max-num-edges-to-remove n edges)
  (define uf-a (new-union-find n))
  (define uf-b (new-union-find n))
  (define removed 0)

  (define (union-all u v)
    (union uf-a u v)
    (union uf-b u v))

  (define (connected-all?)
    (and (connected? uf-a 1) (connected? uf-b 1)))

  (define (union-a u v)
    (union uf-a u v))

  (define (connected-a?)
    (connected? uf-a 1))

  (define (union-b u v)
    (union uf-b u v))

  (define (connected-b?)
    (connected? uf-b 1))

  (for ([edge edges])
    (let ([type (car edge)]
          [u (cadr edge)]
          [v (caddr edge)])
      (cond
        [(equal? type 3)
         (if (connected? uf-a u v)
             (set! removed (+ removed 1))
             (begin
               (union-all u v)
               ))]
        [else #f])))

  (for ([edge edges])
    (let ([type (car edge)]
          [u (cadr edge)]
          [v (caddr edge)])
      (cond
        [(equal? type 1)
         (if (connected? uf-a u v)
             (set! removed (+ removed 1))
             (begin
               (union-a u v)
              ))]
        [(equal? type 2)
         (if (connected? uf-b u v)
             (set! removed (+ removed 1))
             (begin
               (union-b u v)
              ))]
        [else #f])))

  (if (and (connected-a?) (connected-b?))
      removed
      -1))