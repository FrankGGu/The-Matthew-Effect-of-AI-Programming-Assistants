(define (minimum-operations nums k x)
  (define sorted-nums (sort nums (lambda (a b) (> a b))))

  (let loop ((current-nums sorted-nums)
             (current-x x)
             (operations 0)
             (collected-count 0))
    (cond
      ((= collected-count k)
       operations)
      ((empty? current-nums)
       operations)
      (else
       (let ((num (car current-nums)))
         (if (<= num current-x)
             (loop (cdr current-nums)
                   (- num 1)
                   (+ operations 1)
                   (+ collected-count 1))
             (loop (cdr current-nums)
                   current-x
                   operations
                   collected-count)))))))