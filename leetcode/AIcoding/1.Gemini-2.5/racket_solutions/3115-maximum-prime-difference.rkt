(define (maximum-prime-difference n)
  (if (< n 2)
      0
      (begin
        (define is-prime (make-vector (+ n 1) #t))
        (vector-set! is-prime 0 #f)
        (vector-set! is-prime 1 #f)

        (for ([p (in-range 2 (add1 (floor (sqrt n))))])
          (when (vector-ref is-prime p)
            (for ([multiple (in-range (* p p) (add1 n) p)])
              (vector-set! is-prime multiple #f))))

        (define min-p -1)
        (define max-p -1)

        (for ([i (in-range 2 (add1 n))])
          (when (vector-ref is-prime i)
            (when (= min-p -1)
              (set! min-p i))
            (set! max-p i)))

        (if (= min-p -1)
            0
            (- max-p min-p)))))