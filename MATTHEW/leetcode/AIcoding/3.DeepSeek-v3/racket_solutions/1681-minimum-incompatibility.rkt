(define/contract (minimum-incompatibility nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [m (quotient n k)]
         [freq (make-hash)])
    (for ([num nums])
      (hash-update! freq num add1 0))
    (if (ormap (lambda (v) (> v k)) (hash-values freq) -1
        (let ([dp (make-vector (expt 2 n) +inf.0)]
              [nums-list (list->vector (sort nums <))])
          (vector-set! dp 0 0)
          (for ([mask (in-range (expt 2 n))])
            (when (< (vector-ref dp mask) +inf.0)
              (let ([positions (filter (lambda (i) (zero? (bitwise-bit-field mask i (add1 i)))) (range n))])
                (when (>= (length positions) m)
                  (for ([comb (in-combinations positions m)])
                    (let* ([subset (map (lambda (i) (vector-ref nums-list i)) comb)]
                           [unique (remove-duplicates subset)])
                      (when (= (length unique) m)
                        (let* ([new-mask (foldl (lambda (i mask) (bitwise-ior mask (arithmetic-shift 1 i))) mask comb)]
                               [diff (- (apply max subset) (apply min subset))])
                          (vector-set! dp new-mask (min (vector-ref dp new-mask)
                                                      (+ (vector-ref dp mask) diff)))))))))))
          (let ([result (vector-ref dp (sub1 (expt 2 n)))])
            (if (= result +inf.0) -1 result))))))