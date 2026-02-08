(define/contract (pivot-index nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([total (apply + nums)])
    (let loop ([i 0] [left 0])
      (cond
        [(= i (length nums)) -1]
        [(= left (- total left (list-ref nums i))) i]
        [else (loop (+ i 1) (+ left (list-ref nums i)))]))))