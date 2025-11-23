(define (minMoves2 A)
  (define (median lst)
    (let* ([sorted (sort lst <)]
           [n (length sorted)])
      (if (even? n)
          (/ (+ (list-ref sorted (/ n 2))
                (list-ref sorted (- (/ n 2) 1))) 2.0)
          (list-ref sorted (/ n 2)))))

  (define m (median A))
  (foldl (lambda (x acc) (+ acc (abs (- x m)))) 0 A))