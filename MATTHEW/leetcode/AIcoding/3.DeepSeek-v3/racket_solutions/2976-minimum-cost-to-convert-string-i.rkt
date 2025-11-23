(define/contract (minimum-cost source target original changed cost)
  (-> string? string? (listof string?) (listof string?) (listof exact-integer?) exact-integer?)
  (let* ([n (length original)]
         [m (max (apply max (map char->integer (string->list source)))
                 (apply max (map char->integer (string->list target))))]
         [inf +inf.0]
         [dist (make-vector (* (add1 m) (add1 m))])
    (for ([i (in-range (add1 m))])
      (for ([j (in-range (add1 m))])
        (vector-set! dist (+ i (* j (add1 m))) (if (= i j) 0 inf))))
    (for ([o (in-list original)]
          [c (in-list changed)]
          [cost-val (in-list cost)])
      (let ([oi (char->integer (string-ref o 0))]
            [ci (char->integer (string-ref c 0))])
        (when (< cost-val (vector-ref dist (+ oi (* ci (add1 m)))))
          (vector-set! dist (+ oi (* ci (add1 m))) cost-val))))
    (for ([k (in-range (add1 m))])
      (for ([i (in-range (add1 m))])
        (for ([j (in-range (add1 m))])
          (let ([new-cost (+ (vector-ref dist (+ i (* k (add1 m))))
                             (vector-ref dist (+ k (* j (add1 m)))))])
            (when (< new-cost (vector-ref dist (+ i (* j (add1 m)))))
              (vector-set! dist (+ i (* j (add1 m))) new-cost))))))
    (let loop ([i 0]
               [total 0])
      (if (= i (string-length source))
          total
          (let ([s-char (string-ref source i)]
                [t-char (string-ref target i)])
            (if (char=? s-char t-char)
                (loop (add1 i) total)
                (let ([s-int (char->integer s-char)]
                      [t-int (char->integer t-char)])
                  (if (= (vector-ref dist (+ s-int (* t-int (add1 m)))) inf)
                      -1
                      (loop (add1 i) (+ total (vector-ref dist (+ s-int (* t-int (add1 m)))))))))))))