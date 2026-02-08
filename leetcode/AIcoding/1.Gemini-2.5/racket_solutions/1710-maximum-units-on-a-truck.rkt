(require racket/list)

(define (maximum-units boxTypes truckSize)
  (let* ([sorted-box-types (sort boxTypes (lambda (bt1 bt2) (> (second bt1) (second bt2))))])
    (let loop ([remaining-truck-size truckSize]
               [total-units 0]
               [box-types-list sorted-box-types])
      (cond
        [(or (zero? remaining-truck-size) (empty? box-types-list))
         total-units]
        [else
         (let* ([current-box-type (first box-types-list)]
                [num-boxes (first current-box-type)]
                [units-per-box (second current-box-type)]
                [boxes-to-take (min num-boxes remaining-truck-size)])
           (loop (- remaining-truck-size boxes-to-take)
                 (+ total-units (* boxes-to-take units-per-box))
                 (rest box-types-list)))]))))