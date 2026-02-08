(define (maximum-time time)
  (define (replace char idx)
    (cond
      [(equal? char #\?) (case idx
                            [(0) #\2]
                            [(1) #\3]
                            [(3) #\5]
                            [else #\9])]
      [else char]))

  (define new-time (map replace (string->list time) (range (string-length time))))
  (list->string new-time))

(maximum-time "2?:?0")