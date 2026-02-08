(define/contract (watering-plants plants capacity)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([plants plants]
             [current-capacity capacity]
             [steps 0]
             [position -1])
    (if (null? plants)
        steps
        (let ([water-needed (car plants)])
          (if (>= current-capacity water-needed)
              (loop (cdr plants) 
                    (- current-capacity water-needed) 
                    (+ steps 1) 
                    (+ position 1))
              (loop plants 
                    capacity 
                    (+ steps (* 2 (+ position 1))) 
                    -1))))))