(define (max-consecutive-elements xs k)
  (define (helper sorted-xs)
    (let loop ([start 0] [end 0] [cost 0] [max-len 0])
      (cond
        [(>= end (length sorted-xs)) max-len]
        [(<= cost k)
         (let ([len (+ 1 (- end start))])
           (loop start (+ 1 end) cost (max max-len len)))]
        [else
         (loop (+ 1 start) end (- cost (- (list-ref sorted-xs end) (list-ref sorted-xs start))) max-len)])))
  (helper (sort (remove-duplicates xs) <)))