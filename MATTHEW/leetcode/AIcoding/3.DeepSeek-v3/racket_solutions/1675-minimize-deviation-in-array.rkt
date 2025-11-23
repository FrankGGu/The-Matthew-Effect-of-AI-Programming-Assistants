(define/contract (minimum-deviation nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([heap (make-heap (lambda (a b) (< a b)))]
         [max-val -inf.0]
         [min-val +inf.0])
    (for ([num nums])
      (let ([n (if (odd? num) (* num 2) num)])
        (heap-add! heap n)
        (set! max-val (max max-val n))
        (set! min-val (min min-val n))))
    (let loop ([res (- max-val min-val)])
      (if (zero? (modulo (heap-max heap) 2))
          (let* ([current-max (heap-remove-max! heap)]
                 [new-val (/ current-max 2)])
            (heap-add! heap new-val)
            (set! max-val (max new-val (heap-max heap)))
            (set! min-val (min new-val (heap-min heap)))
            (loop (min res (- max-val min-val))))
          res))))