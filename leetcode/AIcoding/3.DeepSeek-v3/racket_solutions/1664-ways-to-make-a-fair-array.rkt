(define (ways-to-make-fair nums)
  (let* ([n (length nums)]
         [prefix (make-vector (+ n 1) 0)]
         [suffix (make-vector (+ n 1) 0)])
    (for ([i (in-range n)])
      (vector-set! prefix (+ i 1) 
                   (+ (vector-ref prefix i) 
                      (if (even? i) (list-ref nums i) (- (list-ref nums i))))))
    (for ([i (in-range (- n 1) -1 -1)])
      (vector-set! suffix i 
                   (+ (vector-ref suffix (+ i 1)) 
                      (if (even? i) (list-ref nums i) (- (list-ref nums i))))))
    (let loop ([i 0] [res 0])
      (if (= i n)
          res
          (if (= (+ (vector-ref prefix i) (vector-ref suffix (+ i 1))) 0)
              (loop (+ i 1) (+ res 1))
              (loop (+ i 1) res))))))