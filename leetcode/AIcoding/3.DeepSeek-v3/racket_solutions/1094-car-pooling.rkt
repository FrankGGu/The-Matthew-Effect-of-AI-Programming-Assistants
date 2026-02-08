(define/contract (car-pooling trips capacity)
  (-> (listof (listof exact-integer?)) exact-integer? boolean?)
  (let* ([max-location (apply max (map third trips))]
         [prefix (make-vector (add1 max-location) 0)])
    (for ([trip trips])
      (let ([num (first trip)]
            [start (second trip)]
            [end (third trip)])
        (vector-set! prefix start (+ (vector-ref prefix start) num))
        (vector-set! prefix end (- (vector-ref prefix end) num))))
    (let loop ([i 1] [current 0])
      (if (> i max-location)
          #t
          (let ([current (+ current (vector-ref prefix i))])
            (if (> current capacity)
                #f
                (loop (add1 i) current)))))))