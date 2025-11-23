(define (min-moves-to-capture-queen queen knight)
  (define (distance q1 q2)
    (let ((x1 (car q1)) (y1 (cadr q1))
          (x2 (car q2)) (y2 (cadr q2)))
      (max (abs (- x1 x2)) (abs (- y1 y2)))))
  (let ((queen-pos (list (car queen) (cadr queen)))
        (knight-pos (list (car knight) (cadr knight))))
    (if (= (distance queen-pos knight-pos) 3)
        2
        (if (= (distance queen-pos knight-pos) 2)
            1
            (if (= (distance queen-pos knight-pos) 1)
                0
                3)))))