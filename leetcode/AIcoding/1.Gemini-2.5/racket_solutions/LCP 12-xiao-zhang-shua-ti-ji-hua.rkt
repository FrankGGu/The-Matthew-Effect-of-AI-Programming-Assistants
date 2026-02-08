(define (max-satisfaction satisfaction)
  (let* ([sorted-satisfaction (sort satisfaction <)]
         [reversed-sorted-satisfaction (reverse sorted-satisfaction)])

    (let loop ([dishes reversed-sorted-satisfaction]
               [max-val 0]
               [current-sum 0]
               [total-satisfaction 0])
      (if (empty? dishes)
          max-val
          (let ([s (car dishes)])
            (if (> (+ total-satisfaction s) 0)
                (loop (cdr dishes)
                      (max max-val (+ current-sum (+ total-satisfaction s)))
                      (+ current-sum (+ total-satisfaction s))
                      (+ total-satisfaction s))
                max-val))))))