(define (watering-plants plants capacity)
  (let loop ([steps 0] [current-capacity capacity] [i 0])
    (cond
      [(= i (length plants)) steps]
      [(>= current-capacity (list-ref plants i))
       (loop (+ steps 1) (- current-capacity (list-ref plants i)) (+ i 1))]
      [else
       (loop (+ steps i 1 i 1) capacity (- current-capacity (list-ref plants i)) (+ i 1))])))