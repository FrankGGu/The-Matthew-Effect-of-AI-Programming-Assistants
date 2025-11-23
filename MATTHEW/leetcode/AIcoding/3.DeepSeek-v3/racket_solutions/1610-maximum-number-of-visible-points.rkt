(define/contract (visible-points points angle location)
  (-> (listof (listof exact-integer?)) exact-integer? (listof exact-integer?) exact-integer?)
  (let* ([x0 (first location)]
         [y0 (second location)]
         [angles (for/list ([p points])
                   (let ([x (first p)]
                         [y (second p)])
                     (if (and (= x x0) (= y y0))
                         -1.0
                         (let ([dx (- x x0)]
                               [dy (- y y0)])
                           (let ([theta (atan dy dx)])
                             (if (negative? theta)
                                 (+ theta (* 2 pi))
                                 theta))))))]
         [angles (filter (lambda (a) (not (negative? a))) angles)]
         [angles (sort angles <)]
         [n (length angles)]
         [angles (append angles (for/list ([a angles]) (+ a (* 2 pi))))]
         [max-angle (degrees->radians angle)]
         [max-count 0]
         [count (count (lambda (a) (and (not (negative? a)) (<= a max-angle))) angles])
    (for ([i (in-range n)])
      (let loop ([j i]
                 [count count])
        (when (< j (+ i n))
          (let ([diff (- (list-ref angles j) (list-ref angles i))])
            (if (<= diff max-angle)
                (begin
                  (set! count (+ count 1))
                  (when (> count max-count)
                    (set! max-count count))
                  (loop (+ j 1) count))
                (begin
                  (set! count (- count 1))
                  (loop j count)))))))
    (+ max-count (count (lambda (a) (negative? a)) angles))))