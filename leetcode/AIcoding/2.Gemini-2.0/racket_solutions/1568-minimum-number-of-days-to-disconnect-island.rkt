(define (min-days grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define (count-islands g)
    (define visited (make-vector rows (make-vector cols #f)))
    (define count 0)

    (define (dfs r c)
      (cond
        [(or (< r 0) (>= r rows) (< c 0) (>= c cols) (vector-ref (vector-ref g r) c) (= 0 (vector-ref (vector-ref g r) c)) (vector-ref (vector-ref visited r) c)) #f]
        [else
         (vector-set! (vector-ref visited r) c #t)
         (dfs (+ r 1) c)
         (dfs (- r 1) c)
         (dfs r (+ c 1))
         (dfs r (- c 1))
         #t]))

    (for/fold ([cnt 0]) ([r (in-range rows)])
      (for/fold ([c-cnt cnt]) ([c (in-range cols)])
        (if (and (= 1 (vector-ref (vector-ref g r) c)) (not (vector-ref (vector-ref visited r) c)))
            (begin (dfs r c) (+ c-cnt 1))
            c-cnt)))
    )

  (define total-ones
    (for/sum ([r (in-range rows)])
      (for/sum ([c (in-range cols)])
        (vector-ref (vector-ref grid r) c))))

  (cond
    [(= total-ones 0) 0]
    [(>= (count-islands grid) 2) 0]
    [(= rows 1) 1]
    [(= cols 1) 1]
    [else
     (let loop ([r 0] [c 0])
       (cond
         [(>= r rows) 2]
         [(>= c cols) (loop (+ r 1) 0)]
         [(= (vector-ref (vector-ref grid r) c) 0) (loop r (+ c 1))]
         [else
          (let ([original (vector-ref (vector-ref grid r) c)])
            (vector-set! (vector-ref grid r) c 0)
            (if (>= (count-islands grid) 2)
                1
                (begin
                  (vector-set! (vector-ref grid r) c original)
                  (loop r (+ c 1)))))]))]))