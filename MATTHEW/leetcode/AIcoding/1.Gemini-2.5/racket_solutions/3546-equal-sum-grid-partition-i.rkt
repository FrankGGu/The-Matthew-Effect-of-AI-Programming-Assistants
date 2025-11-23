(define (equal-sum-grid-partition-i grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (call/cc
   (lambda (return)
     (when (or (< m 2) (< n 2))
       (return #f))

     (define total-sum 0)
     (for* ([r (in-range m)]
            [c (in-range n)])
       (set! total-sum (+ total-sum (vector-ref (vector-ref grid r) c))))

     (unless (zero? (remainder total-sum 4))
       (return #f))
     (define target-sum (/ total-sum 4))

     (define prefix-sum (make-vector (+ m 1) (lambda () (make-vector (+ n 1) 0))))

     (for* ([r (in-range 1 (+ m 1))]
            [c (in-range 1 (+ n 1))])
       (vector-set! (vector-ref prefix-sum r) c
                    (+ (vector-ref (vector-ref grid (- r 1)) (- c 1))
                       (vector-ref (vector-ref prefix-sum (- r 1)) c)
                       (vector-ref (vector-ref prefix-sum r) (- c 1))
                       (- (vector-ref (vector-ref prefix-sum (- r 1)) (- c 1))))))

     (define (get-rect-sum r1 c1 r2 c2)
       (- (+ (vector-ref (vector-ref prefix-sum (+ r2 1)) (+ c2 1))
             (vector-ref (vector-ref prefix-sum r1) c1))
          (vector-ref (vector-ref prefix-sum r1) (+ c2 1))
          (vector-ref (vector-ref prefix-sum (+ r2 1)) c1)))

     (for* ([hr (in-range 0 (- m 1))]
            [vc (in-range 0 (- n 1))])
       (define sum1 (get-rect-sum 0 0 hr vc))
       (define sum2 (get-rect-sum 0 (+ vc 1) hr (- n 1)))
       (define sum3 (get-rect-sum (+ hr 1) 0 (- m 1) vc))
       (define sum4 (get-rect-sum (+ hr 1) (+ vc 1) (- m 1) (- n 1)))

       (when (and (= sum1 target-sum)
                  (= sum2 target-sum)
                  (= sum3 target-sum)
                  (= sum4 target-sum))
         (return #t)))

     #f)))