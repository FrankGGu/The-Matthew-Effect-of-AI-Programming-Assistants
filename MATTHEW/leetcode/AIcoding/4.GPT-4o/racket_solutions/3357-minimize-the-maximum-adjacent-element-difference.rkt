(define (minimizeMax nums k)
  (define (canReduce max-diff)
    (define (countSegments nums max-diff)
      (let loop ((i 0) (count 0))
        (if (>= i (length nums))
            count
            (if (<= (list-ref nums i) (+ max-diff (if (zero? i) 0 (list-ref nums (- i 1)))))
                (loop (+ i 1) count)
                (loop (+ i 1) (+ count 1))))))
    (<= (countSegments nums max-diff) k))

  (define (binarySearch low high)
    (if (= low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (canReduce mid)
              (binarySearch low mid)
              (binarySearch (+ mid 1) high)))))

  (binarySearch 0 (apply max (map - (cdr nums) nums))))