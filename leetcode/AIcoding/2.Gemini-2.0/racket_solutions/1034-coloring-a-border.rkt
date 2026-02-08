(define (color-border grid row col color)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define original-color (list-ref (list-ref grid row) col))
  (define visited (make-matrix rows cols #f))

  (define (is-border? r c)
    (or (< r 0) (>= r rows) (< c 0) (>= c cols)
        (not (= (list-ref (list-ref grid r) c) original-color))))

  (define (dfs r c)
    (cond
      [(or (< r 0) (>= r rows) (< c 0) (>= c cols)
           (list-ref (list-ref visited r) c)
           (not (= (list-ref (list-ref grid r) c) original-color)))
       #f]
      [else
       (matrix-set! visited r c #t)
       (let ([is-border (or (is-border? (sub1 r) c)
                            (is-border? (add1 r) c)
                            (is-border? r (sub1 c))
                            (is-border? r (add1 c)))])
         (dfs (sub1 r) c)
         (dfs (add1 r) c)
         (dfs r (sub1 c))
         (dfs r (add1 c))
         (if is-border
             (matrix-set! grid r c color)
             #f))]))

  (dfs row col)
  grid)

(define (make-matrix rows cols val)
  (for/list ([i rows])
    (for/list ([j cols])
      val)))

(define (matrix-set! mat r c val)
  (set! (list-ref (list-ref mat r) c) val))