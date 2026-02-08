(define/contract (construct-product-matrix grid)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (let* ([m (length grid)]
         [n (if (zero? m) 0 (length (car grid)))]
         [prefix (make-vector (* m n) 1)]
         [suffix (make-vector (* m n) 1)]
         [mod-val 12345])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (let ([idx (+ (* i n) j)])
          (vector-set! prefix idx
                       (if (zero? idx)
                           1
                           (modulo (* (vector-ref prefix (sub1 idx))
                                   mod-val)))
          (vector-set! prefix idx
                       (modulo (* (vector-ref prefix idx)
                                  (list-ref (list-ref grid i) j))
                               mod-val)))))
    (for ([i (in-range (sub1 m) -1 -1)])
      (for ([j (in-range (sub1 n) -1 -1)])
        (let ([idx (+ (* i n) j)])
          (vector-set! suffix idx
                       (if (= idx (sub1 (* m n)))
                           1
                           (modulo (* (vector-ref suffix (add1 idx)))
                                   mod-val)))
          (vector-set! suffix idx
                       (modulo (* (vector-ref suffix idx)
                                (list-ref (list-ref grid i) j))
                               mod-val)))))
    (for/list ([i (in-range m)])
      (for/list ([j (in-range n)])
        (modulo (* (vector-ref prefix (sub1 (+ (* i n) j)))
                   (vector-ref suffix (add1 (+ (* i n) j))))
                mod-val))))