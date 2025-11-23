(define (max-score cardPoints k)
  (let* ((n (length cardPoints))
         (card-vec (list->vector cardPoints))
         (window-size (- n k)))
    (cond
      ((zero? window-size)
       (apply + cardPoints))
      (else
       (let* ((total-sum (for/sum ([x cardPoints]) x))
              (initial-window-sum (for/sum ([i (in-range window-size)])
                                    (vector-ref card-vec i))))
         (let loop ((i window-size)
                    (current-window-sum initial-window-sum)
                    (min-window-sum initial-window-sum))
           (if (= i n)
               (- total-sum min-window-sum)
               (let* ((new-current-window-sum
                       (+ (- current-window-sum (vector-ref card-vec (- i window-size)))
                          (vector-ref card-vec i))))
                 (loop (+ i 1)
                       new-current-window-sum
                       (min min-window-sum new-current-window-sum))))))))))