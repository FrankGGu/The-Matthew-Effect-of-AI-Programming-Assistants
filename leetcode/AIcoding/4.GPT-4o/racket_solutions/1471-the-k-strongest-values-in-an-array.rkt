(define (get-strongest arr k)
  (define sorted-arr (sort arr <))
  (define n (length arr))
  (define median (list-ref (sort arr <) (floor (/ n 2))))
  (define strongest
    (sort (map (lambda (x) (cons (abs (- x median)) x)) arr) >))
  (map second (take strongest k)))

(get-strongest '(1 2 3 4 5) 2)