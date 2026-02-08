(define (minTravelTime operations)
  (define (merge ops)
    (if (null? ops)
        0
        (let loop ((ops ops) (total 0))
          (if (< (length ops) 2)
              total
              (let* ((sorted (sort ops <))
                     (new-op (+ (car sorted) (cadr sorted)))
                     (rest (cddr sorted)))
                (loop (cons new-op rest) (+ total new-op))))))
  (merge (map (lambda (op) (if (number? op) op op)) operations)))

(minTravelTime '(1 2 3 4))