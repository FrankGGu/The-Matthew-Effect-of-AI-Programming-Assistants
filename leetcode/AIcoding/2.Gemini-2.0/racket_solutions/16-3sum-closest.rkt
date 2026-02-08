(define (3sum-closest nums target)
  (define sorted-nums (sort nums <))
  (define n (length sorted-nums))
  (define (abs x) (if (< x 0) (- x) x))
  (define (helper closest left right)
    (cond
      ((>= left right) closest)
      (else
       (let* ((sum (+ (list-ref sorted-nums 0) (list-ref sorted-nums left) (list-ref sorted-nums right)))
              (diff (- sum target))
              (abs-diff (abs diff)))
         (if (< abs-diff (abs (- closest target)))
             (if (> diff 0)
                 (helper sum left (- right 1))
                 (helper sum (+ left 1) right))
             (if (> diff 0)
                 (helper closest left (- right 1))
                 (helper closest (+ left 1) right)))))))

  (let loop ((i 0) (closest (+ (list-ref sorted-nums 0) (list-ref sorted-nums 1) (list-ref sorted-nums 2))))
    (cond
      ((>= i (- n 2)) closest)
      (else
       (let ((new-closest (helper closest (+ i 1) (- n 1))))
         (loop (+ i 1) new-closest))))))