(define (smallest-pair-distance nums k)
  (define (count-pairs dist)
    (let loop ((i 0) (count 0))
      (if (>= i (length nums))
          count
          (let loop2 ((j (+ i 1)) (current-count count))
            (if (>= j (length nums))
                current-count
                (if (<= (- (list-ref nums j) (list-ref nums i)) dist)
                    (loop2 (+ j 1) current-count)
                    (loop2 (+ j 1) (+ current-count (- (length nums) j)))))))))

  (define (binary-search left right)
    (if (= left right) 
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (< (count-pairs mid) k)
              (binary-search (+ mid 1) right)
              (binary-search left mid)))))

  (define sorted-nums (sort nums <))
  (binary-search 0 (- (list-ref sorted-nums (- (length sorted-nums) 1)) (list-ref sorted-nums 0))))