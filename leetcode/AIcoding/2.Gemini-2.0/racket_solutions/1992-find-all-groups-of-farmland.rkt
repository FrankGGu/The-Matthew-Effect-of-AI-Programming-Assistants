(define (find-farmland land)
  (define rows (length land))
  (define cols (length (first land)))
  (define visited (make-vector rows (make-vector cols #f)))
  (define result '())

  (define (dfs r c)
    (cond
      [(or (< r 0) (>= r rows) (< c 0) (>= c cols) (vector-ref (vector-ref land r) c) = 0 (vector-ref (vector-ref visited r) c)) #f]
      [else
       (vector-set! (vector-ref visited r) c #t)
       (dfs (+ r 1) c)
       (dfs r (+ c 1))
       #t]))

  (define (find-bottom-right r c)
    (cond
      [(or (< r 0) (>= r rows) (< c 0) (>= c cols) (vector-ref (vector-ref land r) c) = 0) (list (- r 1) (- c 1))]
      [else
       (find-bottom-right (+ r 1) (+ c 1))]))

  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (and (= (vector-ref (vector-ref land r) c) 1) (not (vector-ref (vector-ref visited r) c)))
        (when (dfs r c)
          (define bottom-right (find-bottom-right r c))
          (set! result (cons (list r c (first bottom-right) (second bottom-right)) result))))))

  (reverse result))