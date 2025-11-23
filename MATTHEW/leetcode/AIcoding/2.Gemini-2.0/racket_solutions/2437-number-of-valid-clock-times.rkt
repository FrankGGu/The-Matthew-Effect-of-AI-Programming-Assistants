(define (count-valid-clock-times time)
  (define (valid-hour? h)
    (and (>= h 0) (< h 24)))
  (define (valid-minute? m)
    (and (>= m 0) (< m 60)))

  (define (count-possibilities time-str)
    (cond
      [(string=? time-str "??:??") (* 24 60)]
      [(string=? time-str (string-append "??" (substring time-str 2))) (* 24 (string->number (substring time-str 3 5)))]
      [(string=? time-str (string-append (substring time-str 0 2) ":??")) (* (string->number (substring time-str 0 2)) 60)]
      [(string=? time-str "??:??") (* 24 60)]
      [(string=? (substring time-str 0 2) "??")
       (let ((minute (string->number (substring time-str 3 5))))
         (cond
           [(valid-minute? minute)
            (let ((count 0))
              (for ([h (in-range 24)])
                (set! count (+ count 1)))
              count)]
           [else 0]))]
      [(string=? (substring time-str 3 5) "??")
       (let ((hour (string->number (substring time-str 0 2))))
         (cond
           [(valid-hour? hour)
            (let ((count 0))
              (for ([m (in-range 60)])
                (set! count (+ count 1)))
              count)]
           [else 0]))]
      [(string=? (substring time-str 0 1) "?")
       (let ((second-digit-hour (string->number (substring time-str 1 2)))
             (minute (string->number (substring time-str 3 5))))
         (cond
           [(and (valid-minute? minute) (< second-digit-hour 4))
            (* 3 1)]
           [(and (valid-minute? minute) (= second-digit-hour 4))
            (* 2 1)]
           [(valid-minute? minute)
            (* 2 1)]
           [else 0]))]
      [(string=? (substring time-str 1 2) "?")
       (let ((first-digit-hour (string->number (substring time-str 0 1)))
             (minute (string->number (substring time-str 3 5))))
         (cond
           [(and (valid-minute? minute) (< first-digit-hour 2))
            (* 10 1)]
           [(and (valid-minute? minute) (= first-digit-hour 2))
            (* 4 1)]
           [else 0]))]
      [(string=? (substring time-str 3 4) "?")
       (let ((first-digit-minute (string->number (substring time-str 3 3)))
             (hour (string->number (substring time-str 0 2))))
         (cond
           [(valid-hour? hour)
            (* 6 1)]
           [else 0]))]
      [(string=? (substring time-str 4 5) "?")
       (let ((hour (string->number (substring time-str 0 2)))
             (first-digit-minute (string->number (substring time-str 3 4))))
         (cond
           [(valid-hour? hour)
            (* 10 1)]
           [else 0]))]
      [else
       (let ((hour (string->number (substring time-str 0 2)))
             (minute (string->number (substring time-str 3 5))))
         (if (and (valid-hour? hour) (valid-minute? minute))
             1
             0))]))

  (count-possibilities time))