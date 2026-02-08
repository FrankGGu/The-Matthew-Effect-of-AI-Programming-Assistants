(define (minTime(nums x)
  (define (possible? k)
    (let loop ((i 0) (sum 0))
      (if (>= i (length nums))
          (<= sum x)
          (let ((new-sum (+ sum (list-ref nums i))))
            (if (<= new-sum x)
                (loop (+ i 1) new-sum)
                (loop (+ i 1) sum))))))

  (define (binary-search left right)
    (if (> left right)
        -1
        (let ((mid (quotient (+ left right) 2)))
          (if (possible? mid)
              (binary-search left (- mid 1))
              (binary-search (+ mid 1) right)))))

  (binary-search 0 (length nums)))

(minTime nums x)