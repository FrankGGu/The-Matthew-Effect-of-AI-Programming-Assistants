(define (can-jump nums)
  (let loop ([i 0] [reachable 0])
    (cond
      [(>= i (length nums)) #t]
      [(< i reachable) (loop (+ i 1) (max reachable (+ i (list-ref nums i))))]
      [(<= i reachable) (loop (+ i 1) (max reachable (+ i (list-ref nums i))))]
      [else #f])))