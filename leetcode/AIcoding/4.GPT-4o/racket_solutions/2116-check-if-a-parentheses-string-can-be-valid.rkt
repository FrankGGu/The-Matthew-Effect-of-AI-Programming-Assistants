(define (checkValidString s)
  (define (helper s open)
    (cond
      [(null? s) (= open 0)]
      [(char=? (car s) #\() (helper (cdr s) (+ open 1))]
      [(char=? (car s) #\)) (and (> open 0) (helper (cdr s) (- open 1)))]
      [(char=? (car s) #\*) (or (helper (cdr s) open) 
                                (helper (cdr s) (+ open 1)) 
                                (and (> open 0) (helper (cdr s) (- open 1))))]
      [else #f]))
  (helper s 0))