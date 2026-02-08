(define (can-see-persons-count heights-list)
  (let* ([heights (list->vector heights-list)]
         [n (vector-length heights)]
         [ans (make-vector n 0)]
         [stack '()])
    (for ([i (range (- n 1) -1 -1)])
      (let ([current-height (vector-ref heights i)])
        (let loop ([s stack] [count 0])
          (if (and (not (empty? s)) (< (car s) current-height))
              (loop (cdr s) (+ count 1))
              (begin
                (vector-set! ans i (if (not (empty? s)) (+ count 1) count))
                (set! stack (cons current-height s)))))))
    (vector->list ans)))