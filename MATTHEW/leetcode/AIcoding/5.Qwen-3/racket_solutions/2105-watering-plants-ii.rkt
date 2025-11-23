(define/contract (watering-plants max-water plants)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [water 0] [steps 0])
    (if (= i (length plants))
        steps
        (let ([need (list-ref plants i)])
          (if (<= water need)
              (loop (+ i 1) (- water need) (+ steps 1))
              (loop i (- max-water need) (+ steps (* 2 (- i 1)) 1)))))))