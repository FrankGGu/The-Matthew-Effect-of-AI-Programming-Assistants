(define (check-if-all-1s-are-at-least-length-k-places-away nums k)
  (let loop ((i 0) (last-one-idx -1))
    (cond
      ((= i (vector-length nums)) #t)
      ((= (vector-ref nums i) 1)
       (if (and (not (= last-one-idx -1))
                (< (- i last-one-idx) (+ k 1)))
           #f
           (loop (+ i 1) i)))
      (else
       (loop (+ i 1) last-one-idx)))))