(define (product-except-self nums)
  (let* ([n (length nums)]
         [prefix-products (make-vector n 1)]
         [suffix-products (make-vector n 1)]
         [result (make-vector n 1)])

    (for ([i (in-range n)])
      (if (= i 0)
          (vector-set! prefix-products i (vector-ref nums i))
          (vector-set! prefix-products i (* (vector-ref prefix-products (- i 1)) (vector-ref nums i)))))

    (for ([i (in-range (sub1 n) -1 -1)])
      (if (= i (sub1 n))
          (vector-set! suffix-products i (vector-ref nums i))
          (vector-set! suffix-products i (* (vector-ref suffix-products (+ i 1)) (vector-ref nums i)))))

    (for ([i (in-range n)])
      (let ([prefix-val (if (= i 0) 1 (vector-ref prefix-products (- i 1)))]
            [suffix-val (if (= i (sub1 n)) 1 (vector-ref suffix-products (+ i 1)))])
        (vector-set! result i (* prefix-val suffix-val))))

    (vector->list result)))