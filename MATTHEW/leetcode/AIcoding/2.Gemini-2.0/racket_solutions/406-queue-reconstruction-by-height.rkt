(define (reconstruct-queue people)
  (let* ((sorted-people (sort people (lambda (a b) (or (> (car a) (car b)) (and (= (car a) (car b)) (< (cadr a) (cadr b)))))))
         (result (make-vector (length sorted-people))))
    (for ([person sorted-people])
      (let loop ([i 0] [count 0])
        (cond
          [(>= count (cadr person))
           (cond
             [(= (vector-ref result i) #f)
              (vector-set! result i person)]
             [else (loop (+ i 1) count)])]
          [else
           (cond
             [(= (vector-ref result i) #f)
              (loop (+ i 1) (+ count 1))]
             [else (loop (+ i 1) count)])])))
    (vector->list result)))