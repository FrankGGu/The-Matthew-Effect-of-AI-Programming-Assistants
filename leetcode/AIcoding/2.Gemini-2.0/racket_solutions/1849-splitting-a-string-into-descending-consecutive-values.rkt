(define (splitting-into-descending-consecutive-values s)
  (define (helper start current)
    (cond
      [(equal? start (string-length s)) #t]
      [else
       (let loop ([i start] [num ""])
         (cond
           [(equal? i (string-length s))
            (if (and (not (equal? num ""))
                     (= current (- (string->number num) 1)))
                (helper i (string->number num))
                #f)]
           [else
            (let ([new-num (string-append num (substring s i (+ i 1)))])
              (if (and (not (equal? num ""))
                       (= current (- (string->number new-num) 1)))
                  (helper (+ i 1) (string->number new-num))
                  (loop (+ i 1) new-num))))]))]))

  (let loop ([i 1] [num ""])
    (cond
      [(equal? i (string-length s)) #f]
      [else
       (let ([new-num (string-append num (substring s 0 i))])
         (if (helper i (string->number new-num))
             #t
             (loop (+ i 1) new-num)))])))