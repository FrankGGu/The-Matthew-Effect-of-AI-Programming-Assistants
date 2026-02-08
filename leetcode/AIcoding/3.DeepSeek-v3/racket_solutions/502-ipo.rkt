(define (find-maximized-capital k w profits capitals)
  (let loop ([k k] [w w] [profits profits] [capitals capitals])
    (if (or (zero? k) (null? profits))
        w
        (let* ([available (filter (lambda (x) (<= (cadr x) w)) (map list profits capitals))]
               [max-profit (if (null? available)
                              0
                              (apply max (map car available))))]
               [new-w (+ w max-profit)]
               [remaining (remove (list max-profit (findf (lambda (x) (= (car x) max-profit)) available)) available)])
          (loop (sub1 k) new-w (map car remaining) (map cadr remaining))))))