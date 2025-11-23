(define (pickGifts gifts k)
  (define (max-pile piles)
    (apply max piles))

  (define (remove-max piles)
    (map (lambda (x) (if (= x (max-pile piles)) (floor (sqrt x)) x)) piles))
  (define (iter piles k)
    (if (zero? k)
        piles
        (iter (remove-max piles) (sub1 k))))

  (apply + (iter gifts k)))