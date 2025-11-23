(define (prev-perm-opt arr)
  (let loop ((i (- (length arr) 2)))
    (cond
      [(< i 0) arr]
      [(= (list-ref arr i) (apply max (list-tail arr (add1 i)))) (loop (- i 1))]
      [else
       (let* ((val (list-ref arr i))
              (j (let loop2 ((j (- (length arr) 1)) (best (- (length arr) 1)))
                   (cond
                     [(< j (add1 i)) best]
                     [(and (< (list-ref arr j) val)
                           (> (list-ref arr j) (list-ref arr best)))
                      (loop2 (- j 1) j)]
                     [else (loop2 (- j 1) best)])))
              (temp (list-ref arr i)))
         (vector->list
          (vector-set! (list->vector arr) i (list-ref arr j))
          (vector-set! (list->vector arr) j temp)))])))