(define/contract (first-missing-positive nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)]
         [contains-one? (for/or ([num nums]) (equal? num 1)])
    (if (not contains-one?)
        1
        (begin
          (for ([i (in-range n)])
            (when (or (<= (vector-ref nums-vec i) 0) (> (vector-ref nums-vec i) n))
              (vector-set! nums-vec i 1)))
          (for ([i (in-range n)])
            (let ([a (abs (vector-ref nums-vec i))])
              (when (equal? (vector-ref nums-vec (sub1 a)) (abs (vector-ref nums-vec (sub1 a))))
                (vector-set! nums-vec (sub1 a) (- (vector-ref nums-vec (sub1 a))))))
          (for/first ([i (in-range n)] #:when (> (vector-ref nums-vec i) 0))
            (+ i 1))
          (add1 n)))))