(define (count-subarrays nums minK maxK)
  (define n (length nums))
  (define (helper nums minK maxK)
    (let loop ([i 0] [start -1] [min-found #f] [max-found #f] [count 0])
      (cond
        [(>= i n) count]
        [else
         (let ([num (list-ref nums i)])
           (cond
             [(or (< num minK) (> num maxK))
              (loop (+ i 1) (+ i 1) #f #f count)]
             [else
              (let ([new-min-found (or min-found (= num minK))]
                    [new-max-found (or max-found (= num maxK))])
                (if (and new-min-found new-max-found)
                    (loop (+ i 1) start new-min-found new-max-found (+ count (- i start)))
                    (loop (+ i 1) start new-min-found new-max-found count))))]))]))
  (helper nums minK maxK))