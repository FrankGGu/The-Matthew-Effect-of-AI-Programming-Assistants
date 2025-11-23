(define (count-triples nums)
  (define n (length nums))
  (define count (make-vector 65536 0))
  (for* ([i nums] [j nums])
    (vector-set! count (bitwise-and i j) (+ (vector-ref count (bitwise-and i j)) 1)))

  (let loop ([i 0] [res 0])
    (if (= i n)
        res
        (let ([num (list-ref nums i)])
          (let loop2 ([j 0] [acc res])
            (if (= j 65536)
                (loop (+ i 1) acc)
                (if (= (bitwise-and num j) 0)
                    (loop2 (+ j 1) (+ acc (vector-ref count j)))
                    (loop2 (+ j 1) acc))))))))

)