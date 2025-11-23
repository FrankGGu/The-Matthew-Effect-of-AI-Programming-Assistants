(define (min-deletion nums)
  (let loop ((i 0) (deletions 0) (filtered '()))
    (cond
      [(>= i (length nums)) (if (odd? (length filtered)) (+ deletions 1) deletions)]
      [(odd? (length filtered))] (loop (+ i 1) deletions filtered)
      [(even? (length filtered))
       (cond
         [(= (+ i 1) (length nums)) (loop (+ i 1) (+ deletions 1) filtered)]
         [(= (list-ref nums i) (list-ref nums (+ i 1))) (loop (+ i 2) (+ deletions 1) filtered)]
         [else (loop (+ i 1) deletions (append filtered (list (list-ref nums i))))])])))