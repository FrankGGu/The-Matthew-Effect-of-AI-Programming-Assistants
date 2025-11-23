(define (minimum-operations x y)
  (let loop ((curr y) (ops 0))
    (cond
      [(> curr x)
       (cond
         [(= (modulo curr 5) 0)
          (min (loop (/ curr 5) (+ ops 1)) (+ ops (- curr x)))]
         [(= (modulo curr 5) 1)
          (min (loop (/ (add1 curr) 5) (+ ops 2)) (+ ops (- curr x))) ]
         [(= (modulo curr 5) 2)
          (min (loop (- curr 2) (+ ops 2)) (+ ops (- curr x)))]
         [(= (modulo curr 5) 3)
          (min (loop (+ curr 2) (+ ops 2)) (+ ops (- curr x)))]
         [(= (modulo curr 5) 4)
          (min (loop (/ (sub1 curr) 5) (+ ops 2)) (+ ops (- curr x)))]
         [else (+ ops (- curr x))])]
      [(= curr x) ops]
      [else (+ ops (- x curr))])))