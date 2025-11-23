(define (count-pairs-complete-day-ii tasks)
  (define n (length tasks))
  (define (date-to-days year month day)
    (+ (* year 365)
       (floor (/ (- year 1) 400))
       (- (floor (/ (- year 1) 100))
          (floor (/ (- year 1) 4)))
       (* month 30)
       day))

  (define (task-to-days task)
    (let* ([s (string-split task "-")]
           [year (string->number (list-ref s 0))]
           [month (string->number (list-ref s 1))]
           [day (string->number (list-ref s 2))])
      (date-to-days year month day)))

  (define days (map task-to-days tasks))

  (let loop ([i 0] [count 0])
    (if (= i n)
        count
        (let loop2 ([j (+ i 1)] [count2 count])
          (if (= j n)
              (loop (+ i 1) count2)
              (if (= (- (list-ref days j) (list-ref days i)) 1)
                  (loop2 (+ j 1) (+ count2 1))
                  (loop2 (+ j 1) count2)))))))