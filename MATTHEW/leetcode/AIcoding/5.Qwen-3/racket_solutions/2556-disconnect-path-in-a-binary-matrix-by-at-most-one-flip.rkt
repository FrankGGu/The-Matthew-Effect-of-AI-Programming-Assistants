#lang racket

(define (is-possible grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define (dfs r c visited)
    (cond [(or (< r 0) (>= r rows) (< c 0) (>= c cols)) #f]
          [(equal? (list-ref (list-ref grid r) c) #\0) #f]
          [(member (list r c) visited) #f]
          [else
           (let ([new-visited (cons (list r c) visited)])
             (or (dfs (+ r 1) c new-visited)
                 (dfs (- r 1) c new-visited)
                 (dfs r (+ c 1) new-visited)
                 (dfs r (- c 1) new-visited)))]))
  (define (check)
    (let loop ([r 0] [c 0])
      (cond [(>= r rows) #t]
            [(>= c cols) (loop (+ r 1) 0)]
            [(equal? (list-ref (list-ref grid r) c) #\1)
             (if (dfs r c '())
                 (loop (+ r (if (= c (sub1 cols)) 1 0)) (if (= c (sub1 cols)) 0 (+ c 1)))
                 #f)]
            [else (loop (+ r (if (= c (sub1 cols)) 1 0)) (if (= c (sub1 cols)) 0 (+ c 1)))]))
  (check))

(define (main grid)
  (is-possible grid))