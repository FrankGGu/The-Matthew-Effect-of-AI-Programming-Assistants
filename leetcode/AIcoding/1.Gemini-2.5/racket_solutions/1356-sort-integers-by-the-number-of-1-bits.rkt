(define (sort-by-bits arr)
  (define (count-set-bits n)
    (let loop ((num n) (count 0))
      (if (zero? num)
          count
          (loop (bitwise-and num (sub1 num)) (add1 count)))))

  (sort arr
        (lambda (a b)
          (let ((bits-a (count-set-bits a))
                (bits-b (count-set-bits b)))
            (if (= bits-a bits-b)
                (< a b)
                (< bits-a bits-b))))))