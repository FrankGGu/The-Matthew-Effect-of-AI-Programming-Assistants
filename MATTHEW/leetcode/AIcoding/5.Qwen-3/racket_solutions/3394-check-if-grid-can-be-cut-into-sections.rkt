#lang racket

(define (valid? grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (define (dfs i j visited)
    (cond [(or (< i 0) (>= i rows) (< j 0) (>= j cols) (not (= (list-ref (list-ref grid i) j) 1)) (member (cons i j) visited)) #f]
          [else
           (let ([new-visited (cons (cons i j) visited)])
             (and (or (dfs (+ i 1) j new-visited)
                      (dfs (- i 1) j new-visited)
                      (dfs i (+ j 1) new-visited)
                      (dfs i (- j 1) new-visited))
                  (not (equal? (list-ref (list-ref grid i) j) 0)))])])
  (let loop ([i 0] [j 0] [visited '()])
    (cond [(>= i rows) #t]
          [(>= j cols) (loop (+ i 1) 0 '())]
          [(= (list-ref (list-ref grid i) j) 1)
           (if (dfs i j '())
               (loop i (+ j 1) '())
               #f)]
          [else (loop i (+ j 1) '())])))

(define/contract (check-if-grid-can-be-cut-into-sections grid)
  (-> (listof (listof exact-integer?)) boolean?)
  (valid? grid))