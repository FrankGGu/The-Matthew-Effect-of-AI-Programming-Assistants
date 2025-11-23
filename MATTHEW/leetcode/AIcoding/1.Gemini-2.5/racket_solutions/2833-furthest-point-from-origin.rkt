(define (furthest-point-from-origin moves)
  (let-values (((num-L num-R num-underscore)
                (string-foldl
                 (lambda (char counts)
                   (match char
                     [#\L (list (+ (car counts) 1) (cadr counts) (caddr counts))]
                     [#\R (list (car counts) (+ (cadr counts) 1) (caddr counts))]
                     [#\_ (list (car counts) (cadr counts) (+ (caddr counts) 1))]
                     [_ (error "Invalid character in moves string")]))
                 (list 0 0 0) ; Initial counts: (num-L num-R num-underscore)
                 moves)))
    (let ((net-RL (- num-R num-L)))
      (+ (abs net-RL) num-underscore))))