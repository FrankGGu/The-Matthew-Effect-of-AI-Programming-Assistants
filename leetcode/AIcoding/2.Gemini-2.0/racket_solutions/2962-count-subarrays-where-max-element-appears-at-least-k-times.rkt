(provide count-subarrays)

(define (count-subarrays nums k)
  (define n (length nums))
  (define max-val (apply max nums))
  (define count 0)

  (for ([i (in-range n)])
    (let loop ([j i] [max-count 0])
      (cond
        [(>= j n) #f]
        [else
         (if (= (list-ref nums j) max-val)
             (loop (+ j 1) (+ max-count 1))
             (loop (+ j 1) max-count))
         (if (>= max-count k)
             (set! count (+ count (- n j)))
             #f)])))
  count)