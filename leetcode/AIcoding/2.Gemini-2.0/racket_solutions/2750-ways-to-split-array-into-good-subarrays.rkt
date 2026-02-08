(define (number-of-ways nums)
  (let* ((n (length nums))
         (first-one (let loop ((i 0))
                       (if (= i n)
                           #f
                           (if (= (list-ref nums i) 1)
                               i
                               (loop (+ i 1))))))
         (last-one (let loop ((i (- n 1)))
                      (if (< i 0)
                          #f
                          (if (= (list-ref nums i) 1)
                              i
                              (loop (- i 1))))))
         (ones (filter (lambda (x) (= x 1)) nums))
         (num-ones (length ones)))
    (if (or (= num-ones 0) (= num-ones 1))
        (if (= num-ones 0)
            0
            1)
        (let loop ((i (+ first-one 1)) (count 1) (prev first-one))
          (if (= i last-one)
              count
              (if (= (list-ref nums i) 1)
                  (loop (+ i 1) (modulo (* count (- i prev)) 1000000007) i)
                  (loop (+ i 1) count prev)))))))