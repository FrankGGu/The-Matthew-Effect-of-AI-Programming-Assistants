(define (count-partitions n k target)
  (define (dp i j)
    (cond
      [(= i 0) (if (= j 0) 1 0)]
      [(> j target) 0]
      [else (+ (dp (- i 1) j) (dp (- i 1) (+ j i)))]))
  (dp n 0))

(define (countGreatPartitions n k target)
  (count-partitions n k target))

(define (countPartitions n k)
  (countGreatPartitions n k (/ (* n (1+ n)) 2)))

(define (numOfGreatPartitions n k)
  (countPartitions n k))