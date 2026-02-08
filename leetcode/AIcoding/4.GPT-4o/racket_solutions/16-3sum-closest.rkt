(define (three-sum-closest nums target)
  (define (closest-sum nums target)
    (define sorted-nums (sort nums <))
    (define n (length sorted-nums))
    (define closest (car sorted-nums))
    (for ([i (in-range n)])
      (define left (+ i 1))
      (define right (- n 1))
      (while (< left right)
        (define current-sum (+ (list-ref sorted-nums i)
                               (list-ref sorted-nums left)
                               (list-ref sorted-nums right)))
        (when (not (= current-sum target))
          (set! closest (if (< (abs (- current-sum target))
                               (abs (- closest target)))
                            current-sum
                            closest)))
        (cond
          [(< current-sum target) (set! left (+ left 1))]
          [(> current-sum target) (set! right (- right 1))]
          [else (set! left (+ left 1))
                (set! right (- right 1))])))
    closest)
  (closest-sum nums target))