#lang racket

(define (solve-n-queens n)
  (define (valid? board row col)
    (for/and ([r (in-range row)])
      (let ([c (vector-ref board r)])
        (not (or (= col c)
                 (= (- row r) (- col c))
                 (= (- row r) (- c col))))))

  (define (backtrack board row res)
    (if (= row n)
        (cons (map (lambda (c) (build-string n (lambda (i) (if (= i c) #\Q #\.)))) (vector->list board)) res)
        (for/fold ([res res]) ([col (in-range n)])
          (if (valid? board row col)
              (begin
                (vector-set! board row col)
                (backtrack board (add1 row) res))
              res))))

  (backtrack (make-vector n -1) 0 '()))

(define (format-solution sol)
  (map (lambda (s) (map list->string s)) sol)

(define (n-queens n)
  (format-solution (solve-n-queens n)))