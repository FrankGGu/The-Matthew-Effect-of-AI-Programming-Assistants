(define/contract (zigzag-skip grid skip)
  (-> (listof (listof exact-integer?)) exact-integer? (listof exact-integer?))
  (let* ([rows (length grid)]
         [cols (if (null? grid) 0 (length (car grid)))]
         [result '()]
         [direction 1]
         [i 0]
         [j 0]
         [count 0])
    (let loop ()
      (when (and (< i rows) (>= i 0) (< j cols) (>= j 0))
        (set! result (cons (list-ref (list-ref grid i) j) result))
        (set! count (+ count 1))
        (if (= (modulo count (+ skip 1)) 0)
            (set! j (+ j 1))
            (begin
              (set! i (+ i direction))
              (when (or (>= i rows) (< i 0))
                (set! direction (* direction -1))
                (set! i (+ i direction direction))
                (set! j (+ j 1)))))
        (loop)))
    (reverse result)))