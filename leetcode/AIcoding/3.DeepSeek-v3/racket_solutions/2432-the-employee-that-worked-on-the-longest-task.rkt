(define/contract (hardest-worker n logs)
  (-> exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (let loop ([logs logs] [prev 0] [max-dur 0] [result 0])
    (if (null? logs)
        result
        (let* ([current (car logs)]
               [id (car current)]
               [time (cadr current)]
               [dur (- time prev)])
          (cond
            [(> dur max-dur) (loop (cdr logs) time dur id)]
            [(= dur max-dur) (loop (cdr logs) time max-dur (min id result))]
            [else (loop (cdr logs) time max-dur result)])))))