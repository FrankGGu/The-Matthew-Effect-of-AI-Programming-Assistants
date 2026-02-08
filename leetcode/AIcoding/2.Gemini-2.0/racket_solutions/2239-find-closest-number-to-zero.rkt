(define (find-closest-number nums)
  (define (abs-val x)
    (if (< x 0) (- x) x))

  (define (closest-helper current-closest remaining-nums)
    (cond
      [(empty? remaining-nums) current-closest]
      [else
       (let* ([first-num (first remaining-nums)]
              [rest-nums (rest remaining-nums)])
         (cond
           [(= (abs-val first-num) (abs-val current-closest))
            (closest-helper (if (< first-num current-closest) current-closest first-num) rest-nums)]
           [(< (abs-val first-num) (abs-val current-closest))
            (closest-helper first-num rest-nums)]
           [else
            (closest-helper current-closest rest-nums)]))]))

  (closest-helper (first nums) (rest nums)))