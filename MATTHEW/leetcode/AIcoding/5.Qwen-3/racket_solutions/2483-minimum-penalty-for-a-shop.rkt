(define/contract (shop-keeper-penalty closed-time)
  (-> exact-nonnegative-integer? exact-integer?)
  (let* ([n (string-length closed-time)]
         [prefix (make-vector n 0)]
         [suffix (make-vector n 0)])
    (vector-set! prefix 0 (if (= (string-ref closed-time 0) #\C) 1 0))
    (for ([i (in-range 1 n)])
      (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (if (= (string-ref closed-time i) #\C) 1 0))))
    (vector-set! suffix (- n 1) (if (= (string-ref closed-time (- n 1)) #\A) 1 0))
    (for ([i (in-range (- n 2) -1 -1)])
      (vector-set! suffix i (+ (vector-ref suffix (+ i 1)) (if (= (string-ref closed-time i) #\A) 1 0))))
    (let loop ([i 0] [min-penalty (vector-ref prefix 0)])
      (if (= i n)
          min-penalty
          (loop (+ i 1) (min min-penalty (+ (vector-ref prefix i) (vector-ref suffix i))))))))