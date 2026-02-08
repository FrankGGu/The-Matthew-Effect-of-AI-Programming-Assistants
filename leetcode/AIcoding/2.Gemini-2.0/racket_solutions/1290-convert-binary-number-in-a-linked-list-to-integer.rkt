(define (get-decimal-value head)
  (let loop ([node head] [acc 0])
    (if (null? node)
        acc
        (loop (cdr node) (+ (* acc 2) (car node))))))