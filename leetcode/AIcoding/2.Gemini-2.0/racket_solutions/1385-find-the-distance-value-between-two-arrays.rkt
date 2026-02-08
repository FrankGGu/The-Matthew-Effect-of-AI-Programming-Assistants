(define (find-the-distance-value arr1 arr2 d)
  (let loop ([lst arr1] [count 0])
    (cond
      [(null? lst) count]
      [else
       (if (not (ormap (lambda (x) (<= (abs (- (car lst) x)) d)) arr2))
           (loop (cdr lst) (+ count 1))
           (loop (cdr lst) count))])))