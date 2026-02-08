(define (pairSum head)
  (define (list->vector lst)
    (let loop ([lst lst] [vec (vector)])
      (if (null? lst)
          (vector-resize! vec 0)
          (begin
            (vector-push-back! vec (car lst))
            (loop (cdr lst) vec)))))

  (define vec (list->vector head))
  (define n (vector-length vec))
  (let loop ([i 0] [max-sum 0])
    (if (= i (/ n 2))
        max-sum
        (let ([current-sum (+ (vector-ref vec i) (vector-ref vec (- n i 1)))])
          (loop (+ i 1) (max max-sum current-sum))))))