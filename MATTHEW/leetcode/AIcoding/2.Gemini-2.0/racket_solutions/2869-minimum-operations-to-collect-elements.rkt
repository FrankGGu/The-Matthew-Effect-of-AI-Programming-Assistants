(define (minOperations xs k)
  (let loop ([xs xs] [count 0] [found 0])
    (cond
      [(empty? xs) -1]
      [(>= found k) count]
      [else
       (let ([x (car xs)])
         (if (and (<= x k) (not (member x (map car (filter (lambda (y) (<= (car y) k)) (reverse (take xs count)))))))
             (loop (cdr xs) (+ count 1) (+ found 1))
             (loop (cdr xs) (+ count 1) found)))])))