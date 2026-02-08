(define (count-collisions directions)
  (let loop ([dirs (string->list directions)]
             [count 0]
             [left-most 'L])
    (cond
      [(empty? dirs) count]
      [else
       (let ([curr (car dirs)])
         (cond
           [(eq? curr #\L)
            (if (eq? left-most #\R)
                (loop (cdr dirs) (+ count 1) 'S)
                (loop (cdr dirs) count 'L))]
           [(eq? curr #\R)
            (loop (cdr dirs) count 'R)]
           [(eq? curr #\S)
            (if (eq? left-most #\R)
                (loop (cdr dirs) (+ count 1) 'S)
                (loop (cdr dirs) count 'S))]
           [else (error "Invalid direction")]))])))