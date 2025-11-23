(define (concatenated-binary n)
  (define (num-bits x)
    (if (= x 0)
        0
        (+ 1 (num-bits (arithmetic-shift x -1)))))

  (let loop ((i 1) (res 0) (mod (expt 10 9 7)))
    (if (> i n)
        res
        (let ((bits (num-bits i)))
          (loop (+ i 1) (modulo (+ (arithmetic-shift res bits) i) mod) mod)))))