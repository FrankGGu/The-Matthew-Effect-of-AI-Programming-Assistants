(define (count-asterisks s)
  (let loop ([str s] [count 0] [in-pair? #f])
    (cond
      [(string=? str "") count]
      [(string=? (substring str 0 1) "*")
       (if (not in-pair?)
           (loop (substring str 1) (+ count 1) in-pair?)
           (loop (substring str 1) count in-pair?))]
      [(string=? (substring str 0 1) "|")
       (loop (substring str 1) count (not in-pair?))]
      [else (loop (substring str 1) count in-pair?)])))