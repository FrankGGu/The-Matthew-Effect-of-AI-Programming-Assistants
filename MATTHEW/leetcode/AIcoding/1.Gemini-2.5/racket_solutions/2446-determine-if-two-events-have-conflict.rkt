(define (parse-time time-str)
  (let* ([parts (string-split time-str ":")]
         [hours (string->number (car parts))]
         [minutes (string->number (cadr parts))])
    (+ (* hours 60) minutes)))

(define (have-conflict event1Start event1End event2Start event2End)
  (let* ([s1 (parse-time event1Start)]
         [e1 (parse-time event1End)]
         [s2 (parse-time event2Start)]
         [e2 (parse-time event2End)])
    (and (<= s1 e2)
         (<= s2 e1))))