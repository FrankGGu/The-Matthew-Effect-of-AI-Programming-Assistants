(define/contract (minimum-difference nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (quotient (length nums) 3)]
         [sorted (sort nums <)]
         [prefix (make-vector (+ n 1) 0)]
         [suffix (make-vector (+ n 1) 0)]
         [min-heap (make-heap <)]
         [max-heap (make-heap >)]
         [sum 0])
    (for ([i (in-range n)])
      (heap-add! max-heap (list-ref sorted i))
      (set! sum (+ sum (list-ref sorted i))))
    (vector-set! prefix n sum)
    (for ([i (in-range n (* 2 n))])
      (heap-add! max-heap (list-ref sorted i))
      (set! sum (+ sum (list-ref sorted i)))
      (set! sum (- sum (heap-remove-max! max-heap)))
      (vector-set! prefix (- (* 2 n) i (- n 1)) sum))
    (set! sum 0)
    (for ([i (in-range (* 2 n) (* 3 n))])
      (heap-add! min-heap (list-ref sorted i))
      (set! sum (+ sum (list-ref sorted i))))
    (vector-set! suffix 0 sum)
    (for ([i (in-range (- (* 2 n) 1) (- n 1) -1)])
      (heap-add! min-heap (list-ref sorted i))
      (set! sum (+ sum (list-ref sorted i)))
      (set! sum (- sum (heap-remove-min! min-heap)))
      (vector-set! suffix (- (* 2 n) i) sum))
    (let loop ([i 0]
               [min-diff +inf.0])
      (if (> i n)
          (exact-round min-diff)
          (loop (+ i 1) (min min-diff (- (vector-ref prefix i) (vector-ref suffix i)))))))