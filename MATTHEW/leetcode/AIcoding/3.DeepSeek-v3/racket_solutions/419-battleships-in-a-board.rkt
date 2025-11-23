(define (count-battleships board)
  (let ((rows (length board))
        (cols (if (null? board) 0 (length (car board)))))
    (let loop ((i 0) (j 0) (count 0))
      (cond
        [(>= i rows) count]
        [(>= j cols) (loop (add1 i) 0 count)]
        [(char=? (list-ref (list-ref board i) j) #\.) (loop i (add1 j) count)]
        [(and (> i 0) (char=? (list-ref (list-ref board (sub1 i)) j) #\X)) (loop i (add1 j) count)]
        [(and (> j 0) (char=? (list-ref (list-ref board i) (sub1 j)) #\X)) (loop i (add1 j) count)]
        [else (loop i (add1 j) (add1 count))]))))