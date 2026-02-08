(define (surfaceArea A)
  (define n (length A))
  (define m (length (car A)))
  (define total-surface-area (* 2 n m))
  (define total-blocks (apply + (apply map + A)))
  (define exposed-sides 
    (apply + 
           (for/list ([i (in-range n)] 
                       [j (in-range m)])
             (let* ((height (list-ref (list-ref A i) j))
                    (adjacent (list 
                                (if (> i 0) (list-ref (list-ref A (- i 1)) j) 0)
                                (if (< i (- n 1)) (list-ref (list-ref A (+ i 1)) j) 0)
                                (if (> j 0) (list-ref (list-ref A i (- j 1))) 0)
                                (if (< j (- m 1)) (list-ref (list-ref A i (+ j 1))) 0)))
                    (visible (apply + (map (lambda (x) (max 0 (- height x))) adjacent))))
              visible))))
  (- total-surface-area total-blocks exposed-sides))

(surfaceArea '((1 2) (3 4)))