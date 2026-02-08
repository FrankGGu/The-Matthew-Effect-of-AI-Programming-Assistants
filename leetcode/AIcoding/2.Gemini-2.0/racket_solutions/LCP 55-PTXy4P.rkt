(define (max-total-distance fruits start-position k)
  (define fruits-sorted (sort fruits < #:key car))
  (define n (length fruits-sorted))
  (define (solve l r move-left move-right)
    (if (> (+ move-left move-right) k)
        -1
        (let ([left-pos (car (list-ref fruits-sorted l))]
              [right-pos (car (list-ref fruits-sorted r))]
              [left-val (cadr (list-ref fruits-sorted l))]
              [right-val (cadr (list-ref fruits-sorted r))])
          (cond
            [(and (= l r) (<= (+ move-left move-right) k))
             (* (+ move-left move-right) left-val)]
            [(> l r) 0]
            [else
             (let ([dist-left (- start-position left-pos)]
                   [dist-right (- right-pos start-position)])
               (max
                (if (<= (+ move-left (+ right-pos left-pos)) k)
                    (+ (* (+ move-left (+ right-pos left-pos)) left-val)
                       (solve (+ l 1) r (+ move-left (+ right-pos left-pos)) move-right))
                    -1)
                (if (<= (+ move-right (+ right-pos left-pos)) k)
                    (+ (* (+ move-right (+ right-pos left-pos)) right-val)
                       (solve l (- r 1) move-left (+ move-right (+ right-pos left-pos))))
                    -1))))))))

  (solve 0 (- n 1) 0 0))