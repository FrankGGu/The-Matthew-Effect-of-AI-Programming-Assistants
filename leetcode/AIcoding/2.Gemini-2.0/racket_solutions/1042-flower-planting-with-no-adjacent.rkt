(define (gardenNoAdj n paths)
  (define adj (make-vector n '()))
  (for-each (lambda (p)
              (let ((u (car p)) (v (cadr p)))
                (vector-set! adj (- u 1) (cons (- v 1) (vector-ref adj (- u 1)))))
              (let ((u (car p)) (v (cadr p)))
                (vector-set! adj (- v 1) (cons (- u 1) (vector-ref adj (- v 1)))))) paths)

  (define colors (make-vector n 0))

  (define (find-color node)
    (let loop ((color 1))
      (cond
        [(> color 4) #f]
        [(not (any? (lambda (neighbor) (= color (vector-ref colors neighbor))) (vector-ref adj node))) color]
        [else (loop (+ color 1))])))

  (for/vector ((i (in-range n)))
    (let ((c (find-color i)))
      (vector-set! colors i c)
      c))
  )