(define (equal-sum-grid-partition grid)
  (define n (length grid))
  (define m (length (first grid)))
  (define prefix-sum (make-vector (+ n 1) (make-vector (+ m 1) 0)))

  (for ([i (in-range n)])
    (for ([j (in-range m)])
      (vector-set! (vector-ref prefix-sum (+ i 1)) (+ j 1)
                   (+ (list-ref (list-ref grid i) j)
                      (vector-ref (vector-ref prefix-sum i) (+ j 1))
                      (vector-ref (vector-ref prefix-sum (+ i 1)) j)
                      (- (vector-ref (vector-ref prefix-sum i) j))))))

  (define (get-sum r1 c1 r2 c2)
    (- (vector-ref (vector-ref prefix-sum (+ r2 1)) (+ c2 1))
       (vector-ref (vector-ref prefix-sum (+ r1 0)) (+ c2 1))
       (vector-ref (vector-ref prefix-sum (+ r2 1)) (+ c1 0))
       (- (vector-ref (vector-ref prefix-sum (+ r1 0)) (+ c1 0)))))

  (define total-sum (vector-ref (vector-ref prefix-sum n) m))

  (define (solve r c)
    (cond
      [(or (= r (- n 1)) (= c (- m 1))) #f]
      [(= (get-sum 0 0 r c) (/ total-sum 2)) #t]
      [(solve (+ r 1) c) #t]
      [(solve r (+ c 1)) #t]
      [else #f]))

  (solve 0 0))