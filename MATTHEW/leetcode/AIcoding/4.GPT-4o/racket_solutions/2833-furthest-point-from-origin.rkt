(define (furthestDistanceFromOrigin(moves))
  (define (count-steps lst)
    (foldl (lambda (x acc) 
              (cond 
                [(equal? x "L") (sub1 acc)]
                [(equal? x "R") (add1 acc)]
                [(equal? x "U") (add1 acc)]
                [(equal? x "D") (sub1 acc)]
                [else acc]))
            0 lst))
  (define step-count (count-steps moves))
  (abs step-count))