(define (max-absolute-sum nums)
  (let loop ([i 0]
             [max-prefix 0]
             [min-prefix 0]
             [current 0]
             [result 0])
    (if (= i (length nums))
        result
        (let* ([current (+ current (list-ref nums i))]
               [new-max (max current max-prefix)]
               [new-min (min current min-prefix)]
               [new-result (max result (abs (- current new-min)) (abs (- current new-max)))])
          (loop (add1 i) new-max new-min current new-result)))))