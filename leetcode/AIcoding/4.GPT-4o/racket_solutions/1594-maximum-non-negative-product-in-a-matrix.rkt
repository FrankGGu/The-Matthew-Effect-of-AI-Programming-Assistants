(define (max-product-path grid)
  (define rows (length grid))
  (define cols (length (first grid)))
  (define dp (make-vector rows (make-vector cols 0)))
  (define mod 1000000007)

  (vector-set! dp 0 (make-vector cols 0))
  (vector-set! (vector-ref dp 0) 0 (if (>= (vector-ref (vector-ref grid 0) 0) 0) (vector-ref (vector-ref grid 0) 0) -1))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (let* ([cell (vector-ref (vector-ref grid i) j)]
             [up (if (> i 0) (vector-ref (vector-ref dp (- i 1)) j) -1)]
             [left (if (> j 0) (vector-ref (vector-ref dp i (- j 1))) -1)]
             [max-product (if (or (= up -1) (= left -1)) -1 (max up left))]
             [new-product (if (>= cell 0) (if (or (= max-product -1) (= max-product 0)) cell (mod (* max-product cell) mod)) -1)])
        (if (>= new-product 0)
          (vector-set! (vector-ref dp i) j new-product)
          (vector-set! (vector-ref dp i) j -1)))))

  (define result (vector-ref (vector-ref dp (- rows 1)) (- cols 1)))
  (if (>= result 0) result -1))

(max-product-path '((1 -2 1) (1 -2 1) (3 4 1)))