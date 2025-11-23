(define (findKthNumber m n k)
  (define (countLessEqual x)
    (define (min a b) (if (< a b) a b))
    (define (count r c)
      (if (zero? r) 0
          (+ (min c (quotient x r)) (count (sub1 r) c))))
    (count m n))

  (define (binarySearch left right)
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (>= (countLessEqual mid) k)
              (binarySearch left mid)
              (binarySearch (add1 mid) right)))))

  (binarySearch 1 (* m n)))