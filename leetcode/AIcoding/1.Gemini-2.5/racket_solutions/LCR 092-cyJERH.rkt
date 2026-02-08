(define (min-flips-mono-incr s)
  (let* ((n (string-length s))
         (prefix-ones (make-vector (+ n 1) 0))
         (suffix-zeros (make-vector (+ n 1) 0)))

    (for ((i (in-range 1 (+ n 1))))
      (vector-set! prefix-ones i
                   (+ (vector-ref prefix-ones (- i 1))
                      (if (char=? (string-ref s (- i 1)) #\1) 1 0))))

    (for ((i (in-range (- n 1) -1 -1)))
      (vector-set! suffix-zeros i
                   (+ (vector-ref suffix-zeros (+ i 1))
                      (if (char=? (string-ref s i) #\0) 1 0))))

    (let loop ((i 0) (min-flips n))
      (if (> i n)
          min-flips
          (loop (+ i 1)
                (min min-flips
                     (+ (vector-ref prefix-ones i)
                        (vector-ref suffix-zeros i))))))))