(define (manhattan-distances-of-all-arrangements pieces)
  (define n (length pieces))
  (define (manhattan p1 p2)
    (+ (abs (- (car p1) (car p2)))
       (abs (- (cdr p1) (cdr p2)))))

  (define (helper current-arrangement remaining-pieces current-distance all-distances)
    (if (empty? remaining-pieces)
        (cons current-distance all-distances)
        (foldr
         (lambda (piece acc)
           (helper (append current-arrangement (list piece))
                   (remove piece remaining-pieces)
                   (+ current-distance
                      (if (empty? current-arrangement)
                          0
                          (manhattan (car (last current-arrangement)) piece)))
                   acc))
         all-distances
         remaining-pieces)))

  (sort (helper '() pieces 0 '()) <))