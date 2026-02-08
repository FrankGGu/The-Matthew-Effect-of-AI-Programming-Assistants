(define (mem-leak mem1 mem2)
  (let loop ((t 1) (m1 mem1) (m2 mem2))
    (cond
      ((and (< m1 t) (< m2 t))
       (list t m1 m2))
      ((>= m1 m2)
       (loop (+ t 1) (- m1 t) m2))
      (else
       (loop (+ t 1) m1 (- m2 t))))))