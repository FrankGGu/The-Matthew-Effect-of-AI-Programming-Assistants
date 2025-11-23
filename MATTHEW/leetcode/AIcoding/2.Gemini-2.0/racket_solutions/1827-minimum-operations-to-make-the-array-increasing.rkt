(define (min-operations nums)
  (let loop ((i 1) (prev (car nums)) (ops 0))
    (if (null? (cdr nums))
        ops
        (let ((curr (car (cdr nums))))
          (if (<= curr prev)
              (loop (+ i 1) (+ prev 1) (+ ops (- (+ prev 1) curr)))
              (loop (+ i 1) curr ops))))))