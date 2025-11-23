(define (closest-dessert-cost base-costs topping-costs target)

  (define current-min-diff (abs (- (car base-costs) target)))
  (define current-closest-cost (car base-costs))

  (define (update-closest cost)
    (let ((diff (abs (- cost target))))
      (cond
        ((< diff current-min-diff)
         (set! current-min-diff diff)
         (set! current-closest-cost cost))
        ((and (= diff current-min-diff)
              (< cost current-closest-cost))
         (set! current-closest-cost cost)))))

  (for-each (lambda (base-cost)
              (define (explore-toppings topping-idx current-topping-sum)
                (cond
                  ((= topping-idx (length topping-costs))
                   (update-closest (+ base-cost current-topping-sum)))
                  (else
                   (let ((topping-val (list-ref topping-costs topping-idx)))
                     (explore-toppings (+ topping-idx 1) current-topping-sum)
                     (explore-toppings (+ topping-idx 1) (+ current-topping-sum topping-val))
                     (explore-toppings (+ topping-idx 1) (+ current-topping-sum (* 2 topping-val)))))))
              (explore-toppings 0 0))

  current-closest-cost)