(define (reformat s)
  (let* ([chars (string->list s)]
         [digits (filter char-numeric? chars)]
         [letters (filter char-alphabetic? chars)]
         [len-d (length digits)]
         [len-l (length letters)])
    (cond
      ((> (abs (- len-d len-l)) 1) "")
      (else
       (let loop ([res '()]
                  [d-list digits]
                  [l-list letters]
                  [turn (cond
                          ((> len-d len-l) 'digit)
                          ((> len-l len-d) 'letter)
                          (else 'letter))])
         (cond
           ((and (empty? d-list) (empty? l-list)) (list->string (reverse res)))
           ((eq? turn 'digit)
            (loop (cons (car d-list) res) (cdr d-list) l-list 'letter))
           (else ; turn is 'letter
            (loop (cons (car l-list) res) d-list (cdr l-list) 'digit))))))))