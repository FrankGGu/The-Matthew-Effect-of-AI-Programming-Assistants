(define (maxCoins bags k)
  (define (max-from-bags bags k)
    (if (zero? k)
        0
        (if (null? bags)
            0
            (let* ((take-from-here (car bags))
                   (take (max-from-bags (cdr bags) (- k 1)))
                   (skip (max-from-bags (cdr bags) k)))
              (max (+ take-from-here take) skip)))))
  (max-from-bags bags k))

(maxCoins '(1 2 3 4 5) 3)