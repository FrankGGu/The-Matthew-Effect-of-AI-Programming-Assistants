(define (valid-tic-tac-toe board)
  (let* ([x-count (count-char board #\X)]
         [o-count (count-char board #\O)]
         [x-win (win? board #\X)]
         [o-win (win? board #\O)])
    (and (<= (- x-count o-count) 1)
         (>= x-count o-count)
         (not (and x-win o-win))
         (or (not x-win) (= (- x-count o-count) 1))
         (or (not o-win) (= x-count o-count)))))

(define (count-char board char)
  (for*/sum ([row (in-list board)]
             [c (in-string row)])
    (if (char=? c char) 1 0)))

(define (win? board char)
  (or (for/or ([row (in-list board)])
        (and (char=? (string-ref row 0) char)
             (char=? (string-ref row 1) char)
             (char=? (string-ref row 2) char))
      (for/or ([col (in-range 3)])
        (and (char=? (string-ref (list-ref board 0) col) char)
             (char=? (string-ref (list-ref board 1) col) char)
             (char=? (string-ref (list-ref board 2) col) char)))
      (and (char=? (string-ref (list-ref board 0) 0) char)
           (char=? (string-ref (list-ref board 1) 1) char)
           (char=? (string-ref (list-ref board 2) 2) char))
      (and (char=? (string-ref (list-ref board 0) 2) char)
           (char=? (string-ref (list-ref board 1) 1) char)
           (char=? (string-ref (list-ref board 2) 0) char))))