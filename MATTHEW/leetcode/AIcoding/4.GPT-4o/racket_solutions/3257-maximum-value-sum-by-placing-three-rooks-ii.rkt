(define (maxValueSum grid)
  (define n (length grid))
  (define m (length (first grid)))
  (define (dp i j k)
    (if (= i n)
        0
        (let loop ((x 0) (best 0))
          (if (= x m)
              best
              (let* ((current (if (and (<= k x) (< x m)) (list-ref (list-ref grid i) x) 0))
                     (new-best (max best (+ current (dp (add1 i) (if (= x m) 0 (add1 x)) (if (= current 0) k (+ k 1))))))
                     (next-best (loop (add1 x) new-best)))
                next-best)))))
  (dp 0 0 0))

(maxValueSum '((1 2 3) (4 5 6) (7 8 9)))