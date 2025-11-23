(define (max-increasing-groups arr)
  (define sorted-arr (sort arr <))
  (define (helper sorted-arr current-group-size groups-count)
    (cond
      [(empty? sorted-arr) groups-count]
      [(>= (car sorted-arr) current-group-size)
       (helper (cdr sorted-arr) (+ 1 current-group-size) (+ 1 groups-count))]
      [else (helper (cdr sorted-arr) current-group-size groups-count)]))
  (helper sorted-arr 1 0))