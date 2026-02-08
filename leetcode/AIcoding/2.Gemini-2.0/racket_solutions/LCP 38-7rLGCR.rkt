(define (守卫城堡 heights)
  (let* ([n (length heights)]
         [left (make-vector n 0)]
         [right (make-vector n 0)])
    (let loop ([i 1] [max-left (vector-ref heights 0)])
      (if (= i n)
          void
          (begin
            (vector-set! left i max-left)
            (loop (+ i 1) (max max-left (vector-ref heights i))))))
    (let loop ([i (- n 2)] [max-right (vector-ref heights (- n 1))])
      (if (< i 0)
          void
          (begin
            (vector-set! right i max-right)
            (loop (- i 1) (max max-right (vector-ref heights i))))))
    (let loop ([i 1] [ans 0])
      (if (= i (- n 1))
          ans
          (let ([min-height (min (vector-ref left i) (vector-ref right i))])
            (if (> min-height (vector-ref heights i))
                (loop (+ i 1) (+ ans (- min-height (vector-ref heights i))))
                (loop (+ i 1) ans)))))))