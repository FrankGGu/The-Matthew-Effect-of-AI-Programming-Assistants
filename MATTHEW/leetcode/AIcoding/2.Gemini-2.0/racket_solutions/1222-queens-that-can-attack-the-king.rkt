(define (queensAttacktheKing queens king)
  (define (attack? queen)
    (let ([qx (car queen)]
          [qy (cdr queen)]
          [kx (car king)]
          [ky (cdr king)])
      (or (= qx kx) (= qy ky) (= (- qx kx) (- qy ky)) (= (- qx kx) (- ky qy)))))

  (define (find-closest direction)
    (let ([dx (car direction)]
          [dy (cdr direction)])
      (let loop ([dist 1])
        (let ([x (+ (car king) (* dist dx))]
              [y (+ (cdr king) (* dist dy))])
          (if (or (< x 0) (< y 0) (>= x 8) (>= y 8))
              #f
              (let ([potential-queen (cons x y)])
                (if (member potential-queen queens equal?)
                    potential-queen
                    (loop (+ dist 1)))))))))

  (define directions
    (list (cons 0 1) (cons 0 -1) (cons 1 0) (cons -1 0)
          (cons 1 1) (cons 1 -1) (cons -1 1) (cons -1 -1)))

  (filter identity (map find-closest directions)))