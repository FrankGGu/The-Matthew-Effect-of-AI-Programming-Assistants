(define (catAndMouse II catA catB mouseC)
  (define (dfs catA catB mouseC turn)
    (cond
      [(= mouseC catA) 1]
      [(= mouseC catB) -1]
      [(= turn 0) (if (< (abs (- mouseC catA)) (abs (- mouseC catB))) 1 -1)]
      [else
       (define nextCats (if (= turn 1) (list (add1 catA) (sub1 catA)) (list catB)))
       (define nextMouses (list (add1 mouseC) (sub1 mouseC)))
       (define results (for/list ([nextCat nextCats]
                                  [nextMouse nextMouses])
                          (when (and (>= nextCat 1) (<= nextCat 3)
                                     (>= nextMouse 1) (<= nextMouse 3))
                            (dfs nextCat catB nextMouse (if (= turn 1) 0 1)))))
       (if (or (member 1 results) (not (member -1 results)))
           1
           -1)))]))
  (dfs catA catB mouseC 0))