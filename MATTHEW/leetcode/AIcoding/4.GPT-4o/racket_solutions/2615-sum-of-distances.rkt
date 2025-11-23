(define (sumOfDistances nums)
  (define n (length nums))
  (define counts (make-vector (add1 (apply max nums)) 0))
  (define distances (make-vector (add1 (apply max nums)) 0))

  (for ([num nums])
    (vector-set! counts num (+ 1 (vector-ref counts num))))

  (for ([i (in-range (vector-length counts))])
    (for ([j (in-range (vector-length counts))])
      (when (and (not (= i j)) (> (vector-ref counts j) 0))
        (vector-set! distances i (+ (vector-ref distances i) (* (vector-ref counts j) (abs (- i j))))))))

  (for ([i (in-range (vector-length counts))])
    (vector-set! distances i (if (> (vector-ref counts i) 0) (vector-ref distances i) 0)))

  (apply + (vector->list distances)))

(sumOfDistances (list 1 2 1 2 1))