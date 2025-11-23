(define (find-best-value arr target)
  (define (calculate-and arr mid)
    (foldl (lambda (x acc) (min x mid)) 0 arr))

  (define (find-closest arr target low high)
    (if (<= low high)
        (let ((mid (quotient (+ low high) 2)))
          (let ((sum (foldl (lambda (x acc) (+ acc (min x mid))) 0 arr)))
            (cond
              ((= sum target) mid)
              ((< sum target) (find-closest arr target (+ mid 1) high))
              (else (find-closest arr target low (- mid 1))))))

        (let* ((low-sum (foldl (lambda (x acc) (+ acc (min x low))) 0 arr))
               (high-sum (foldl (lambda (x acc) (+ acc (min x high))) 0 arr)))
          (if (<= (abs (- low-sum target)) (abs (- high-sum target)))
              low
              high)))))

  (define (calculate-sum arr)
     (foldl + 0 arr))

  (let* ((arr-sum (calculate-sum arr))
         (n (length arr))
         (avg (quotient (+ arr-sum n -1) n ))
         (max-val (apply max arr)))

     (if (<= arr-sum target)
         max-val
         (find-closest arr target 0 max-val))))