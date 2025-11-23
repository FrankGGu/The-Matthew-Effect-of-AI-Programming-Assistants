(define (alphabet-board-path target)
  (define board '(#\a #\b #\c #\d #\e
                 #\f #\g #\h #\i #\j
                 #\k #\l #\m #\n #\o
                 #\p #\q #\r #\s #\t
                 #\u #\v #\w #\x #\y #\z))
  (define (get-pos char)
    (let loop ([i 0])
      (cond
        [(equal? (list-ref board i) char) i]
        [else (loop (+ i 1))])))
  (define (get-row pos)
    (quotient pos 5))
  (define (get-col pos)
    (remainder pos 5))
  (define (path-from start-pos end-pos)
    (let* ([start-row (get-row start-pos)]
           [start-col (get-col start-pos)]
           [end-row (get-row end-pos)]
           [end-col (get-col end-pos)]
           [row-diff (- end-row start-row)]
           [col-diff (- end-col start-col)])
      (string-append
       (cond
         [(> row-diff 0) (make-string row-diff #\D)]
         [(< row-diff 0) (make-string (- row-diff) #\U)]
         [else ""])
       (cond
         [(> col-diff 0) (make-string col-diff #\R)]
         [(< col-diff 0) (make-string (- col-diff) #\L)]
         [else ""]))))

  (let loop ([chars (string->list target)]
             [curr-pos 0]
             [result ""])
    (cond
      [(null? chars) result]
      [else
       (let* ([next-char (car chars)]
              [next-pos (get-pos next-char)]
              [move-path (path-from curr-pos next-pos)])
         (loop (cdr chars) next-pos (string-append result move-path "!" )))])))