(define (navigate-robot moves)
  (define directions (vector 0 1 2 3)) ; 0: north, 1: east, 2: south, 3: west
  (define position (list 0 0))
  (define dir 0)

  (for-each (lambda (move)
              (cond
                [(equal? move "G") 
                 (cond
                   [(= dir 0) (set! position (list (+ (car position) 1) (cadr position)))]
                   [(= dir 1) (set! position (list (car position) (+ (cadr position) 1)))]
                   [(= dir 2) (set! position (list (- (car position) 1) (cadr position)))]
                   [(= dir 3) (set! position (list (car position) (- (cadr position) 1)))])]
                [(equal? move "L") 
                 (set! dir (modulo (- dir 1) 4))]
                [(equal? move "R") 
                 (set! dir (modulo (+ dir 1) 4))])))
            moves)

  (and (equal? position '(0 0)) (= dir 0)))