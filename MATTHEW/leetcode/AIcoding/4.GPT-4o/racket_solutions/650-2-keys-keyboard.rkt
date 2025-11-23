(define (minSteps n)
  (define (helper current clipboard steps)
    (cond
      [(= current n) steps]
      [(> current n) +inf.0]
      [else
       (min (helper current current (+ steps 1)) ; Copy
            (helper (+ current clipboard) clipboard (+ steps 1)) ; Paste
            (helper current clipboard (+ steps 1)))]))
  (helper 1 0 0))

(minSteps 3)