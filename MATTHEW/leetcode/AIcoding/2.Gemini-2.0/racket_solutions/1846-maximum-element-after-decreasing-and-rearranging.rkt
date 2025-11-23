(define (maximum-element-after-decreasing-and-rearranging arr)
  (define sorted-arr (sort arr <))
  (define n (length sorted-arr))
  (define (helper i prev)
    (cond
      [(= i n) prev]
      [(= i 0) (helper (+ i 1) 1)]
      [(<= (list-ref sorted-arr i) (+ prev 1)) (helper (+ i 1) (list-ref sorted-arr i))]
      [else (helper (+ i 1) (+ prev 1))]))
  (helper 0 0))