(define (summary-ranges nums)
  (define (format-range start end)
    (if (= start end)
        (number->string start)
        (format "~a->~a" start end)))

  (define (process-ranges current-result-reversed current-start remaining-nums)
    (cond
      [(empty? remaining-nums)
       current-result-reversed]

      [(empty? (rest remaining-nums))
       (cons (format-range current-start (car remaining-nums)) current-result-reversed)]

      [else
       (let* ([current-val (car remaining-nums)]
              [next-val (cadr remaining-nums)])
         (if (= next-val (+ current-val 1))
             (process-ranges current-result-reversed current-start (rest remaining-nums))
             (process-ranges (cons (format-range current-start current-val) current-result-reversed)
                             next-val
                             (rest remaining-nums))))]))

  (if (empty? nums)
      '()
      (reverse (process-ranges '() (car nums) nums))))