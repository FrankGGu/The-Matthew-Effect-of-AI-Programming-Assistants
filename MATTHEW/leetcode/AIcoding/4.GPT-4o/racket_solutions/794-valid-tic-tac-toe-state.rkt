(define (valid-tic-tac-toe board)
  (define (count char)
    (apply + (map (lambda (row) (count (string->list row) char)) board)))

  (define (winner char)
    (or (and (= (char->integer (string-ref (list-ref board 0) 0)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 0) 1)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 0) 2)) (char->integer char)))
        (and (= (char->integer (string-ref (list-ref board 1) 0)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 1) 1)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 1) 2)) (char->integer char)))
        (and (= (char->integer (string-ref (list-ref board 2) 0)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 2) 1)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 2) 2)) (char->integer char)))
        (and (= (char->integer (string-ref (list-ref board 0) 0)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 1) 0)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 2) 0)) (char->integer char)))
        (and (= (char->integer (string-ref (list-ref board 0) 1)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 1) 1)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 2) 1)) (char->integer char)))
        (and (= (char->integer (string-ref (list-ref board 0) 2)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 1) 2)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 2) 2)) (char->integer char)))
        (and (= (char->integer (string-ref (list-ref board 0) 0)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 1) 1)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 2) 2)) (char->integer char)))
        (and (= (char->integer (string-ref (list-ref board 0) 2)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 1) 1)) (char->integer char))
             (= (char->integer (string-ref (list-ref board 2) 0)) (char->integer char)))))

  (define x-count (count #\X))
  (define o-count (count #\O))

  (cond
    [(> x-count o-count 1) #f]
    [(< x-count o-count) #f]
    [(and (= x-count o-count) (or (winner #\X) (winner #\O))) #f]
    [(and (= x-count (+ o-count 1)) (winner #\O)) #f]
    [(and (= x-count (+ o-count 1)) (winner #\X)) #t]
    [(and (= x-count o-count) (winner #\X)) #t]
    [else #t]))