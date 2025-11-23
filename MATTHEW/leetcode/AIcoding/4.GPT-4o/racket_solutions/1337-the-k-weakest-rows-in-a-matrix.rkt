(define (k-weakest-rows matrix k)
  (define (count-soldiers row)
    (foldl (lambda (x acc) (if (= x 1) (+ acc 1) acc)) 0 row))
  (define indexed-rows
    (map (lambda (row idx) (list (count-soldiers row) idx)) matrix))
  (define sorted-rows (sort indexed-rows (lambda (a b) (or (< (car a) (car b)) (and (= (car a) (car b)) (< (cadr a) (cadr b)))))))
  (map cadr (take sorted-rows k)))

(k-weakest-rows '(((1 1 0 0) (1 1 0 0) (1 0 0 0) (1 0 0 0)) 3)