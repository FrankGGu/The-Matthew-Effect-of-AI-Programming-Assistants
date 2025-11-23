(define (execute-instructions n commands)
  (define (move x y dir)
    (cond [(char=? #\U dir) (values x (- y 1))]
          [(char=? #\D dir) (values x (+ y 1))]
          [(char=? #\L dir) (values (- x 1) y)]
          [(char=? #\R dir) (values (+ x 1) y)]))

  (define (valid? x y)
    (and (>= x 0) (< x n) (>= y 0) (< y n)))

  (define (process cmd idx x y res)
    (if (= idx (string-length cmd))
        res
        (let* ((dir (string-ref cmd idx))
               (new-x (car (move x y dir)))
               (new-y (cdr (move x y dir))))
          (if (valid? new-x new-y)
              (process cmd (+ idx 1) new-x new-y (cons (add1 (car res)) (cdr res)))
              (process cmd (+ idx 1) new-x new-y (cons 0 (cdr res)))))))

  (define (loop i res)
    (if (= i (string-length commands))
        res
        (let* ((x 0)
               (y 0)
               (count (process commands 0 x y (cons 0 '())))
               (new-res (append res (list (car count)))))
          (loop (+ i 1) new-res))))

  (loop 0 '()))