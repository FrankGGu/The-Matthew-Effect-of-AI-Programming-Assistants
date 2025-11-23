#lang racket

(define (place-word-in-crossword board word)
  (define n (length board))
  (define m (if (> n 0) (length (car board)) 0))
  (define len (string-length word))
  (define (check-row i j dir)
    (let loop ([k 0] [x j] [y i])
      (cond [(= k len) #t]
            [(or (< x 0) (>= x m) (< y 0) (>= y n)) #f]
            [(not (char=? (string-ref word k) (string-ref (list-ref board y) x))) #f]
            [else (loop (+ k 1) (if dir x (+ x 1)) (if dir (+ y 1) y))])))
  (define (check-col i j dir)
    (let loop ([k 0] [x j] [y i])
      (cond [(= k len) #t]
            [(or (< x 0) (>= x m) (< y 0) (>= y n)) #f]
            [(not (char=? (string-ref word k) (string-ref (list-ref board y) x))) #f]
            [else (loop (+ k 1) (if dir x (+ x 1)) (if dir (+ y 1) y))])))
  (for/or ([i (in-range n)] [j (in-range m)])
    (and (or (check-row i j #t) (check-row i j #f) (check-col i j #t) (check-col i j #f)))))

(define (solve)
  (let* ([input (read-line)]
         [word (read-line)]
         [board (map (lambda (line) (string->list line)) (take (port->lines (current-input-port)) (string->number input)))])
    (printf "~a\n" (if (place-word-in-crossword board word) "true" "false"))))

(solve)