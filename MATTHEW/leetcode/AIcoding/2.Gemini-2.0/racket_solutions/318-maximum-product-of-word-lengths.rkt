(define (maximum-product-word-lengths words)
  (let* ([n (length words)]
         [masks (make-vector n 0)]
         (for ([i (in-range n)])
           (for ([c (in-string (list-ref words i))])
             (vector-set! masks i (bitwise-ior (vector-ref masks i) (bitwise-arithmetic-shift-left 1 (- (char->integer c) (char->integer #\a))))))))
    (let loop ([i 0] [max-product 0])
      (if (= i n)
          max-product
          (let loop2 ([j (add1 i)])
            (if (= j n)
                (loop (add1 i) max-product)
                (if (zero? (bitwise-and (vector-ref masks i) (vector-ref masks j)))
                    (loop2 (add1 j) (max max-product (* (string-length (list-ref words i)) (string-length (list-ref words j)))))
                    (loop2 (add1 j) max-product))))))))