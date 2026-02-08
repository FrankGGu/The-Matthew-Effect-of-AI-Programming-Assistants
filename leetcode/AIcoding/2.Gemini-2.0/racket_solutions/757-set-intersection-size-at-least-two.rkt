(define (intersection-size-two intervals)
  (define sorted-intervals (sort intervals (lambda (a b) (if (= (car a) (car b)) (< (cdr a) (cdr b)) (< (car a) (car b))))))
  (define (solve intervals count last last2)
    (if (null? intervals)
        count
        (let* ((interval (car intervals))
               (start (car interval))
               (end (cdr interval)))
          (cond
            ((and (>= start last) (>= start last2))
             (solve (cdr intervals) (+ count 2) end (- end 1)))
            ((>= start last)
             (solve (cdr intervals) (add1 count) end last))
            (else
             (solve (cdr intervals) count last last2))))))
  (if (null? intervals)
      0
      (if (= (length intervals) 1)
          2
          (solve (cdr sorted-intervals) 2 (cdr (car sorted-intervals)) (- (cdr (car sorted-intervals)) 1)))))