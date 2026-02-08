(define (min-difficulty job-difficulty d)
  (define n (length job-difficulty))
  (if (> d n)
      -1
      (let ((dp (make-vector (+ 1 d) (make-vector (+ 1 n) +inf.0))))
        (vector-set! (vector-ref dp 0) 0 0)
        (for* ((i (in-range 1 (+ 1 d)))
               (j (in-range 1 (+ 1 n))))
          (let loop ((k j)
                     (max-so-far 0))
            (if (zero? k)
                #t
                (begin
                  (set! max-so-far (max max-so-far (list-ref job-difficulty (- k 1))))
                  (vector-set! (vector-ref dp i) j (min (vector-ref (vector-ref dp i) j) (+ max-so-far (vector-ref (vector-ref dp (- i 1)) (- k 1)))))
                  (loop (- k 1) max-so-far)))))
        (if (= (vector-ref (vector-ref dp d) n) +inf.0)
            -1
            (vector-ref (vector-ref dp d) n)))))