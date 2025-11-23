(define (to-minutes time-str)
  (let* ([parts (string-split time-str ":")]
         [h (string->number (car parts))]
         [m (string->number (cadr parts))])
    (+ (* h 60) m)))

(define (minimum-time-difference time-list)
  (let* ([n (length time-list)]
         [times (map to-minutes time-list)]
         [sorted-times (sort times <)])
    (let loop ([i 0] [min-diff 1440])
      (if (= i n)
          min-diff
          (let* ([diff (modulo (- (list-ref sorted-times (modulo (+ i 1) n)) (list-ref sorted-times i)) 1440)]
                 [new-min-diff (min min-diff diff)])
            (loop (+ i 1) new-min-diff))))))