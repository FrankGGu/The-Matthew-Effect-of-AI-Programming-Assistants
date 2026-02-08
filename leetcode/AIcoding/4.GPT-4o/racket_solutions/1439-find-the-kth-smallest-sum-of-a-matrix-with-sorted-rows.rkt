(define (kth-smallest(matrix k)
  (define (generate-sums rows)
    (if (null? rows)
        '(0)
        (let ((next-sums (generate-sums (cdr rows))))
          (apply append
                 (map (lambda (x)
                        (map (lambda (y) (+ x y))
                             (car rows)))
                      next-sums)))))

  (define all-sums (generate-sums matrix))
  (define sorted-sums (sort all-sums <))
  (list-ref sorted-sums (sub1 k)))

(define (kth-smallest-sum matrix k)
  (kth-smallest matrix k))