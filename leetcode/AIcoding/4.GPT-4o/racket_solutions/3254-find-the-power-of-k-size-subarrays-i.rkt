(define (countKSizeSubarrays nums k)
  (define (helper nums k)
    (let loop ((i 0) (count 0) (current-sum 0))
      (if (>= i (length nums))
          count
          (begin
            (set! current-sum (+ current-sum (list-ref nums i)))
            (if (= (modulo current-sum k) 0)
                (loop (+ i 1) (+ count 1) current-sum)
                (loop (+ i 1) count current-sum))))))
  (helper nums k))