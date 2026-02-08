(define (count-ways n prev)
  (define MOD 1000000007)
  (define (factorial x)
    (let loop ((i x) (acc 1))
      (if (= i 0)
          acc
          (loop (- i 1) (modulo (* acc i) MOD)))))

  (define (inverse x)
    (expt x (- MOD 2) MOD))

  (define (combinations n k)
    (if (or (< k 0) (> k n))
        0
        (modulo (* (factorial n)
                   (modulo (* (inverse (factorial k))
                              (inverse (factorial (- n k))))
                           MOD))
                MOD)))

  (let loop ((i 0) (sizes (make-vector n 1)) (result 1))
    (if (= i n)
        result
        (let* ((parent (vector-ref prev i))
               (child-size (vector-ref sizes i))
               (parent-size (vector-ref sizes parent)))
          (vector-set! sizes parent (+ parent-size child-size))
          (let ((ways (combinations (+ parent-size child-size -1) child-size)))
            (loop (+ i 1) sizes (modulo (* result ways) MOD)))))))