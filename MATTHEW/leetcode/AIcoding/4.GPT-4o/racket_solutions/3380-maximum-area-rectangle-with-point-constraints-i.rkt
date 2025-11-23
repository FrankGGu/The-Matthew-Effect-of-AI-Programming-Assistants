(define (max-area-rectangle points)
  (define (area p1 p2)
    (let-values ([(x1 y1) p1
                  (x2 y2) p2])
      (* (abs (- x1 x2)) (abs (- y1 y2)))))

  (define (valid-rectangle p1 p2 p3 p4)
    (and (equal? (car p1) (car p3)) (equal? (cadr p2) (cadr p4))
         (equal? (cadr p1) (cadr p3)) (equal? (car p2) (car p4))))

  (define max-area 0)
  (define n (length points))

  (for ([i (in-range n)])
    (for ([j (in-range (add1 i) n)])
      (for ([k (in-range n)])
        (for ([l (in-range (add1 k) n)])
          (when (and (not (= i k)) (not (= i l)) (not (= j k)) (not (= j l)))
            (when (valid-rectangle (list-ref points i) (list-ref points j) 
                                   (list-ref points k) (list-ref points l))
              (set! max-area (max max-area (area (list-ref points i) (list-ref points j))))))))))

  max-area)