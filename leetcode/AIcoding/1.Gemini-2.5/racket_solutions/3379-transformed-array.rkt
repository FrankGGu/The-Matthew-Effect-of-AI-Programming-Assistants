(define (sort-transformed-array nums a b c)
  (define (f x a b c)
    (+ (* a x x) (* b x) c))

  (define n (length nums))
  (if (= n 0)
      '()
      (begin
        (define nums-vec (list->vector nums))
        (define result (make-vector n))

        (cond
          [(= a 0) ; Linear function: f(x) = bx + c
           (define transformed-list (map (lambda (x) (f x 0 b c)) nums))
           (if (>= b 0)
               transformed-list
               (reverse transformed-list))]

          [(> a 0) ; Parabola opens upwards, min at vertex, max at ends
           ; Fill result from right to left (largest values)
           (let loop ((left 0)
                      (right (- n 1))
                      (idx (- n 1)))
             (when (<= left right)
               (define val-left (f (vector-ref nums-vec left) a b c))
               (define val-right (f (vector-ref nums-vec right) a b c))
               (if (> val-left val-right)
                   (begin
                     (vector-set! result idx val-left)
                     (loop (+ left 1) right (- idx 1)))
                   (begin
                     (vector-set! result idx val-right)
                     (loop left (- right 1) (- idx 1))))))
           (vector->list result)]

          [(< a 0) ; Parabola opens downwards, max at vertex, min at ends
           ; Fill result from left to right (smallest values)
           (let loop ((left 0)
                      (right (- n 1))
                      (idx 0))
             (when (<= left right)
               (define val-left (f (vector-ref nums-vec left) a b c))
               (define val-right (f (vector-ref nums-vec right) a b c))
               (if (< val-left val-right)
                   (begin
                     (vector-set! result idx val-left)
                     (loop (+ left 1) right (+ idx 1)))
                   (begin
                     (vector-set! result idx val-right)
                     (loop left (- right 1) (+ idx 1))))))
           (vector->list result)])))))