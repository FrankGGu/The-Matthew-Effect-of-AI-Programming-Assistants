(define (reverse-string-ii s k)
  (define len (string-length s))
  (define result (make-string len #\space))

  (let loop ((i 0))
    (cond
      ((>= i len) result)
      (else
       (define end (min (+ i k) len))
       (define rev-end (min (+ i (* 2 k)) len))

       (let rev-loop ((j (- end 1)) (l i))
         (cond
           ((< j i) 'done)
           (else
            (string-set! result l (string-ref s j))
            (rev-loop (- j 1) (+ l 1)))))

       (let normal-loop ((j end) (l end))
         (cond
           ((>= j rev-end) 'done)
           (else
            (string-set! result l (string-ref s j))
            (normal-loop (+ j 1) (+ l 1)))))

       (loop (+ i (* 2 k)))))))