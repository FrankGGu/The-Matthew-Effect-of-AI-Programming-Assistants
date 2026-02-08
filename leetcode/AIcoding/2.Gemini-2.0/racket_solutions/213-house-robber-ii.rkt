(define (rob nums)
  (define (helper nums)
    (let ((n (length nums)))
      (if (zero? n)
          0
          (let loop ((i 1) (rob-prev (list (car nums))) (skip-prev (list 0)))
            (if (= i n)
                (max (last rob-prev) (last skip-prev))
                (loop (+ i 1)
                      (append rob-prev (list (+ (list-ref nums i) (last skip-prev))))
                      (append skip-prev (list (max (last rob-prev) (last skip-prev))))))))))

  (define n (length nums))
  (if (zero? n)
      0
      (if (= n 1)
          (car nums)
          (max (helper (take nums (- n 1))) (helper (drop nums 1))))))