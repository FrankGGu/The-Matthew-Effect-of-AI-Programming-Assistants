(define (num-of-subarrays arr k threshold)
  (let* ([n (length arr)]
         [target (* k threshold)]
         [count 0]
         [sum (if (>= n k) (apply + (take arr k)) 0)])
    (if (>= sum target)
        (set! count (+ count 1))
        #f)
    (for ([i (in-range k n)])
      (set! sum (- sum (list-ref arr (- i k))))
      (set! sum (+ sum (list-ref arr i)))
      (if (>= sum target)
          (set! count (+ count 1))
          #f))
    count))