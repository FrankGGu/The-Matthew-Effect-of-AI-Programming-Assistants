(define (inventory-manage stock)
  (if (null? stock)
      0
      (let ((min-val (apply min stock)))
        (if (= min-val (car stock))
            0
            (let loop ((i 1) (count 0))
              (if (= i (length stock))
                  count
                  (if (= (list-ref stock i) min-val)
                      (loop (+ i 1) (+ count 1))
                      (loop (+ i 1) count))))))))