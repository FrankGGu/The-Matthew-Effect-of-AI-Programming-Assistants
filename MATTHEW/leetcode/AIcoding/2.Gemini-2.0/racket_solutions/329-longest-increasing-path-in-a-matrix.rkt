(define (longest-increasing-path matrix)
  (define rows (length matrix))
  (define cols (length (first matrix)))
  (define memo (make-vector (* rows cols) #f))

  (define (dfs r c)
    (cond
      [(vector-ref memo (+ (* r cols) c))
       (vector-ref memo (+ (* r cols) c))]
      [else
       (define up (if (and (> r 0) (> (list-ref (list-ref matrix r) c) (list-ref (list-ref matrix (- r 1)) c)))
                      (dfs (- r 1) c)
                      0))
       (define down (if (and (< r (- rows 1)) (> (list-ref (list-ref matrix r) c) (list-ref (list-ref matrix (+ r 1)) c)))
                        (dfs (+ r 1) c)
                        0))
       (define left (if (and (> c 0) (> (list-ref (list-ref matrix r) c) (list-ref (list-ref matrix r) (- c 1))))
                        (dfs r (- c 1))
                        0))
       (define right (if (and (< c (- cols 1)) (> (list-ref (list-ref matrix r) c) (list-ref (list-ref matrix r) (+ c 1))))
                         (dfs r (+ c 1))
                         0))
       (vector-set! memo (+ (* r cols) c) (+ 1 (max up down left right)))
       (vector-ref memo (+ (* r cols) c))]))

  (define max-path-length 0)
  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (set! max-path-length (max max-path-length (dfs r c)))))

  max-path-length)