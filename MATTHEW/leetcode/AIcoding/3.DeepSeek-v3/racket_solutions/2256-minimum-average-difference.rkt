(define/contract (minimum-average-difference nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [prefix (make-vector n 0)]
         [suffix (make-vector n 0)]
         [min-avg-diff +inf.0]
         [result 0])
    (vector-set! prefix 0 (list-ref nums 0))
    (for ([i (in-range 1 n)])
      (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (list-ref nums i))))
    (vector-set! suffix (- n 1) (list-ref nums (- n 1)))
    (for ([i (in-range (- n 2) -1 -1)])
      (vector-set! suffix i (+ (vector-ref suffix (+ i 1)) (list-ref nums i))))
    (for ([i (in-range 0 n)])
      (let* ([left (quotient (vector-ref prefix i) (+ i 1))]
             [right (if (= i (- n 1)) 0 (quotient (vector-ref suffix (+ i 1)) (- n i 1)))]
             [avg-diff (abs (- left right))])
        (when (< avg-diff min-avg-diff)
          (set! min-avg-diff avg-diff)
          (set! result i))))
    result))