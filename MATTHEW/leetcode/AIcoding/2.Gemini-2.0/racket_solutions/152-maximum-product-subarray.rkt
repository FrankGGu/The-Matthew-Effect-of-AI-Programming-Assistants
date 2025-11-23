(define (max-product nums)
  (let loop ((i 1)
             (max-so-far (car nums))
             (min-so-far (car nums))
             (result (car nums)))
    (if (= i (length nums))
        result
        (let ((curr (list-ref nums i)))
          (let ((temp-max (* max-so-far curr))
                (temp-min (* min-so-far curr)))
            (let ((new-max (max curr temp-max temp-min))
                  (new-min (min curr temp-max temp-min)))
              (loop (+ i 1)
                    new-max
                    new-min
                    (max result new-max))))))))