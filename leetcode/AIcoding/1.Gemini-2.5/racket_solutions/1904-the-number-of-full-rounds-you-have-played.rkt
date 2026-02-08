(define (parse-time time-str)
  (let* ([parts (string-split time-str ":")]
         [hour (string->number (car parts))]
         [minute (string->number (cadr parts))])
    (+ (* hour 60) minute)))

(define (number-of-full-rounds-you-have-played start-time-str finish-time-str)
  (let* ([start-minutes (parse-time start-time-str)]
         [finish-minutes (parse-time finish-time-str)]
         [adjusted-finish-minutes
          (if (< finish-minutes start-minutes)
              (+ finish-minutes (* 24 60))
              finish-minutes)]
         [effective-start-minutes
          (* (ceiling (/ start-minutes 15)) 15)]
         [effective-finish-minutes
          (* (floor (/ adjusted-finish-minutes 15)) 15)])
    (if (< effective-finish-minutes effective-start-minutes)
        0
        (quotient (- effective-finish-minutes effective-start-minutes) 15))))