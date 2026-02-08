(define (max-absolute-sum nums)
  (if (empty? nums)
      0
      (let* ((first-num (car nums)))
        (let loop ((lst (cdr nums))
                   (max-ending-here first-num)
                   (min-ending-here first-num)
                   (max-overall first-num)
                   (min-overall first-num))
          (if (empty? lst)
              (max (abs max-overall) (abs min-overall))
              (let* ((num (car lst))
                     (new-max-ending-here (max num (+ max-ending-here num)))
                     (new-min-ending-here (min num (+ min-ending-here num)))
                     (current-max-overall (max max-overall new-max-ending-here))
                     (current-min-overall (min min-overall new-min-ending-here)))
                (loop (cdr lst)
                      new-max-ending-here
                      new-min-ending-here
                      current-max-overall
                      current-min-overall))))))