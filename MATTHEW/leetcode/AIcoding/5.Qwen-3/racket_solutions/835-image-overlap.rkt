(define (overlap a b)
  (define (get-coords img)
    (for*/list ([i (in-range (length img))]
                [j (in-range (length (vector-ref img 0)))])
      (when (= 1 (vector-ref (vector-ref img i) j))
        (cons i j))))

  (define coords-a (get-coords a))
  (define coords-b (get-coords b))

  (define (count-overlap dx dy)
    (for/sum ([p-a (in-list coords-a)])
      (if (member (cons (+ (car p-a) dx) (+ (cdr p-a) dy)) coords-b)
          1
          0)))

  (define max-dx (max (apply max (map car coords-a)) (apply max (map car coords-b))))
  (define max-dy (max (apply max (map cdr coords-a)) (apply max (map cdr coords-b))))

  (define (range n)
    (if (>= n 0)
        (range (- n 1) (- n 1))
        (range 0 n)))

  (define (range start end)
    (if (> start end)
        '()
        (cons start (range (+ start 1) end))))

  (apply max (for/list ([dx (in-range (- max-dx) (+ max-dx 1))]
                        [dy (in-range (- max-dy) (+ max-dy 1))])
               (count-overlap dx dy))))