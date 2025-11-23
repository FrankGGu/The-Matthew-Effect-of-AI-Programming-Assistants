(define/contract (minimum-time nums1 nums2 x)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length nums1)]
         [pairs (sort (for/list ([a nums1] [b nums2]) (cons a b))
                      (lambda (x y) (< (cdr x) (cdr y))))]
         [dp (make-vector (add1 n) -inf.0)]
         [max-time 0])
    (vector-set! dp 0 0)
    (for ([pair (in-list pairs)])
      (let ([a (car pair)]
            [b (cdr pair)])
      (for ([k (in-range n (sub1 0) -1)])
        (when (>= (vector-ref dp (sub1 k)) -inf.0)
          (vector-set! dp k (max (vector-ref dp k)
                                 (+ (vector-ref dp (sub1 k)) 
                                    (+ a (* b k)))))))
    (set! max-time (max max-time (vector-ref dp k))))
    (let loop ([t 0]
               [sum1 (apply + nums1)]
               [sum2 (apply + nums2)])
      (cond
        [(<= sum1 x) t]
        [(= t n) -1]
        [else (loop (add1 t)
                    (- sum1 sum2)
                    sum2)]))))