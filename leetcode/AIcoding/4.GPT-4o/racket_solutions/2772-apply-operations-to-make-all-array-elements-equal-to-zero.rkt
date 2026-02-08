(define (applyOperations nums)
  (for ([i (in-range (sub1 (length nums)))])
    (when (= (list-ref nums i) 0)
      (set! (list-ref nums i) (list-ref nums (+ i 1)))
      (set! (list-ref nums (+ i 1)) 0)))
  (define result (filter (lambda (x) (not (= x 0))) nums))
  (append result (make-list (- (length nums) (length result)) 0)))

(applyOperations '(1 2 0 0 3 0))