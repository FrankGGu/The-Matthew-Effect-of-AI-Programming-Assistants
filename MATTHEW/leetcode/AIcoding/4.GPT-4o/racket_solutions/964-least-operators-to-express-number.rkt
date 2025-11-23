(define (least-operators-to-express-number x target)
  (define (helper num ops)
    (if (= num target) ops
        (if (or (> num target) (> ops 32)) 32
            (min (helper (+ num x) (+ ops 1))
                 (helper (* num x) (+ ops 1))))))
  (if (= x target) 1
      (if (= x 1) (if (= target 0) 0 32) (helper x 1))))