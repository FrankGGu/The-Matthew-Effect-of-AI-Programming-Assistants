(define (maxElementSum nums)
  (define (helper indices)
    (if (null? indices)
        0
        (+ (car indices) (helper (cdr indices)))))
  (define (complete-subset-sum indices)
    (if (null? indices)
        0
        (max (complete-subset-sum (cdr indices))
             (+ (car indices) (complete-subset-sum (filter (lambda (x) (> x (car indices))) (cdr indices)))))))
  (complete-subset-sum nums))

(maxElementSum '(1 2 3 4 5))