(define (color-border grid row col color)
  (define m (length grid))
  (define n (length (car grid)))
  (define original (array-ref grid row col))
  (define visited (make-vector m (make-vector n #f)))
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))
  (define border (vector))

  (define (in-bounds? r c)
    (and (>= r 0) (< r m) (>= c 0) (< c n)))

  (define (is-border? r c)
    (for/or ([d directions])
      (let* ([new-r (+ r (car d))]
             [new-c (+ c (cadr d))])
        (and (in-bounds? new-r new-c)
             (not (= (array-ref grid new-r new-c) original)))))

  (define (dfs r c)
    (vector-set! visited r c #t)
    (if (is-border? r c)
        (vector-push! border (list r c)))
    (for ([d directions])
      (let* ([new-r (+ r (car d))]
             [new-c (+ c (cadr d))])
        (when (and (in-bounds? new-r new-c)
                   (not (vector-ref visited new-r new-c))
                   (= (array-ref grid new-r new-c) original))
          (dfs new-r new-c)))))

  (dfs row col)

  (for ([b border])
    (let* ([r (car b)]
           [c (cadr b)])
      (array-set! grid r c color)))

  grid)