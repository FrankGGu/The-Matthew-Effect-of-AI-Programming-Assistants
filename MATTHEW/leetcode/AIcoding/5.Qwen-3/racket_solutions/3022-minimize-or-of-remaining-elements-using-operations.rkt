(define (minimize-or-remaining-elements nums)
  (define (helper nums i or_val)
    (if (= i (length nums))
        or_val
        (let ((new_or (bitwise-ior or_val (list-ref nums i))))
          (min (helper nums (+ i 1) new_or)
               (helper nums (+ i 1) or_val)))))
  (helper nums 0 0))