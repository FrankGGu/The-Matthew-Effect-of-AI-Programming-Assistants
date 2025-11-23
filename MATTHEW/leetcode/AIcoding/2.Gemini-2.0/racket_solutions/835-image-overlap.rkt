(define (largest-overlap A B)
  (define n (vector-length A))
  (define (overlap dx dy)
    (let loop ((i 0) (j 0) (count 0))
      (cond
        ((= i n) count)
        ((= j n) (loop (+ i 1) 0 count))
        (else
         (if (and (>= (+ i dx) 0) (< (+ i dx) n) (>= (+ j dy) 0) (< (+ j dy) n))
             (if (and (= (vector-ref A i) 1) (= (vector-ref B (+ i dx) (+ j dy)) 1))
                 (loop i (+ j 1) (+ count 1))
                 (loop i (+ j 1) count))
             (loop i (+ j 1) count))))))
  (let loop ((dx (- n 1)) (dy (- n 1)) (max-overlap 0))
    (cond
      ((< dx (- n 1)) max-overlap)
      ((< dy (- n 1)) (loop dx (+ dy 1) max-overlap))
      (else
       (let ((current-overlap (overlap dx dy)))
         (loop (+ dx 1) (- n 1) (max max-overlap current-overlap)))))))