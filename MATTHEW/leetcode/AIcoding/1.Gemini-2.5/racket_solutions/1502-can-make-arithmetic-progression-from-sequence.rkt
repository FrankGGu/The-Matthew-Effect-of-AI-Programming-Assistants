(define (can-make-arithmetic-progression arr)
  (define n (length arr))
  (if (<= n 2)
      #t
      (let* ([sorted-arr (sort arr <)]
             [first-val (car sorted-arr)]
             [second-val (cadr sorted-arr)]
             [diff (- second-val first-val)])
        (let loop ([lst (cddr sorted-arr)]
                   [prev-val second-val])
          (cond
            [(empty? lst) #t]
            [(= diff (- (car lst) prev-val))
             (loop (cdr lst) (car lst))]
            [else #f])))))