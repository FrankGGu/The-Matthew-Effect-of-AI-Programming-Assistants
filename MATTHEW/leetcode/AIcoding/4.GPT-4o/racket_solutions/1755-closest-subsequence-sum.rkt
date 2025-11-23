(define (closest-subsequence-sum nums goal)
  (define (subsets lst)
    (if (null? lst)
        (list '())
        (let ((rest (subsets (cdr lst))))
          (append rest (map (lambda (x) (cons (car lst) x)) rest)))))

  (define all-sums
    (map (lambda (s) (apply + s)) (subsets nums)))

  (define (closest sum)
    (foldl (lambda (x y) (if (< (abs (- y goal)) (abs (- x goal))) y x)) sum all-sums))

  (closest (car all-sums)))