(define (number-of-boomerangs points)
  (define (sq x) (* x x))

  (define (dist-sq p1 p2)
    (let* ((x1 (car p1))
           (y1 (cadr p1))
           (x2 (car p2))
           (y2 (cadr p2)))
      (+ (sq (- x2 x1))
         (sq (- y2 y1)))))

  (define n (length points))

  (for/sum ([i (in-range n)])
    (define center-point (list-ref points i))
    (define dist-counts (make-hash))

    (for ([j (in-range n)])
      (unless (= i j)
        (define other-point (list-ref points j))
        (define d (dist-sq center-point other-point))
        (hash-set! dist-counts d (add1 (hash-ref dist-counts d 0)))))

    (for/sum ([(dist count) (in-hash dist-counts)])
      (if (>= count 2)
          (* count (sub1 count))
          0))))