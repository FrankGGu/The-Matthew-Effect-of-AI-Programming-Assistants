(define (count-students preferences sandwiches)
  (let loop ([prefs preferences] [sands sandwiches] [count 0])
    (cond
      [(empty? prefs) count]
      [(empty? sands) count]
      [(= (car prefs) (car sands)) (loop (cdr prefs) (cdr sands) count)]
      [else (let ([new-prefs (append (cdr prefs) (list (car prefs)))])
              (if (equal? new-prefs prefs)
                  (+ count (length prefs))
                  (loop new-prefs sands (+ count 0))))])))