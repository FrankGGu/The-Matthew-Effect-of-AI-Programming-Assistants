(define (getBiggestThreeRhombusSums grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))
  (define sums (make-hash))

  (define (valid? r c)
    (and (>= r 0) (< r m) (>= c 0) (< c n)))

  (define (rhombus-sum r c k)
    (let loop ((i 1) (sum 0))
      (if (> i k)
          sum
          (begin
            (let ((r1 (- r i)) (c1 c))
              (if (valid? r1 c1) (set! sum (+ sum (vector-ref (vector-ref grid r1) c1)))))
            (let ((r2 (+ r i)) (c2 c))
              (if (valid? r2 c2) (set! sum (+ sum (vector-ref (vector-ref grid r2) c2)))))
            (let ((r3 r) (c3 (- c i)))
              (if (valid? r3 c3) (set! sum (+ sum (vector-ref (vector-ref grid r3) c3)))))
            (let ((r4 r) (c4 (+ c i)))
              (if (valid? r4 c4) (set! sum (+ sum (vector-ref (vector-ref grid r4) c4)))))
            (loop (+ i 1) sum)))))

  (for ((r (in-range m))
        (c (in-range n)))
    (hash-set! sums (vector-ref (vector-ref grid r) c) #t))

  (for ((r (in-range m))
        (c (in-range n)))
    (for ((k (in-range 1 (min (+ (min r (- m r -1)) (min c (- n c -1))) 
                                (+ 1 (min (- m r -1) (min r c (- n c -1))))))
               ))
      (hash-set! sums (- (rhombus-sum r c k) (vector-ref (vector-ref grid r) c)) #t)))

  (define sorted-sums (sort (hash-keys sums) >))
  (take sorted-sums (min 3 (length sorted-sums))))