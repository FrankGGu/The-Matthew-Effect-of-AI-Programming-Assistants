(define (minimizeManhattanDistance A B)
  (define (manhattan-distance p1 p2)
    (+ (abs (- (car p1) (car p2))) (abs (- (cadr p1) (cadr p2)))))

  (define (total-distance perm)
    (apply + (map (lambda (i) (manhattan-distance (list (list-ref A i) (list-ref B i)) (list (list-ref A (list-ref perm i)) (list-ref B (list-ref perm i))))) (range (length A)))))

  (define (permute lst)
    (if (null? lst)
        (list '())
        (apply append
               (map (lambda (x)
                      (map (lambda (p) (cons x p))
                           (permute (remove x lst))))
                    lst))))

  (define all-perms (permute (range (length A))))
  (apply min (map total-distance all-perms)))

(define (minimize-distance A B)
  (minimizeManhattanDistance A B))