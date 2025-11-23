(define (find-min-cost perm)
  (define (cost perm)
    (foldl (lambda (x acc) (+ acc (abs (- x (car perm))))) 0 (cdr perm)))
  (define (permute lst)
    (if (null? lst)
        (list '())
        (apply append
               (map (lambda (x)
                      (map (lambda (p)
                             (cons x p))
                           (permute (remove x lst))))
                    lst))))
  (define min-cost
    (apply min
           (map cost (permute perm))))
  min-cost)

(find-min-cost '(1 2 3))