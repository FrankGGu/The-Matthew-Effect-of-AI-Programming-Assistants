(define (minimize-maximum nums)
  (define n (length nums))

  (define (check x)
    (let loop ((i 0) (current-sum 0))
      (if (= i n)
          #t
          (let* ((num-i (list-ref nums i))
                 (new-sum (+ current-sum num-i)))
            (if (> (ceiling (/ new-sum (+ i 1))) x)
                #f
                (loop (+ i 1) new-sum))))))

  (let* ((low 0)
         (high (apply max nums))
         (ans high))

    (let loop ((l low) (h high) (current-ans ans))
      (if (> l h)
          current-ans
          (let* ((mid (+ l (quotient (- h l) 2))))
            (if (check mid)
                (loop l (- mid 1) mid)
                (loop (+ mid 1) h current-ans)))))))