(define (count-range-sum nums lower upper)
  (define (merge-sort sums start end)
    (if (>= start end)
        (if (< start (vector-length sums)) 1 0)
        (let* ([mid (quotient (+ start end) 2)]
               [count (+ (merge-sort sums start mid)
                         (merge-sort sums (+ mid 1) end))])
          (let loop ([i start] [j (+ mid 1)] [k (+ mid 1)] [l (+ mid 1)])
            (if (> i mid)
                count
                (begin
                  (while (and (<= j end) (< (vector-ref sums j) (+ (vector-ref sums i) lower)))
                    (set! j (+ j 1)))
                  (while (and (<= k end) (<= (vector-ref sums k) (+ (vector-ref sums i) upper)))
                    (set! k (+ k 1)))
                  (loop (+ i 1) j k l)))))))
  (let* ([n (length nums)]
         [sums (make-vector (+ n 1) 0)])
    (for ([i (in-range 1 (+ n 1))])
      (vector-set! sums i (+ (vector-ref sums (- i 1)) (list-ref nums (- i 1)))))
    (merge-sort sums 0 n)))