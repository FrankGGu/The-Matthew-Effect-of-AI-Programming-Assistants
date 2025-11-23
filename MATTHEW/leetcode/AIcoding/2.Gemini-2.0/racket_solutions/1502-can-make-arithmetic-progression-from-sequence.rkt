(define (can-make-arithmetic-progression arr)
  (let* ([sorted-arr (sort arr <)]
         [diff (if (null? sorted-arr) 0 (- (list-ref sorted-arr 1) (list-ref sorted-arr 0)))]
         [len (length sorted-arr)])
    (cond
      [(<= len 2) #t]
      [else (let loop ([i 2])
              (cond
                [(>= i len) #t]
                [(= diff (- (list-ref sorted-arr i) (list-ref sorted-arr (- i 1)))) (loop (+ i 1))]
                [else #f]))])))