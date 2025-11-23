#lang racket

(define (unique-paths-iii grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define start #f)
  (define end #f)
  (define empty 0)

  (for* ([i (in-range rows)]
         [j (in-range cols)])
    (let ([cell (list-ref (list-ref grid i) j)])
      (cond
        [(= cell 1) (set! start (cons i j))]
        [(= cell 2) (set! end (cons i j))]
        [(= cell 0) (set! empty (add1 empty))])))

  (define (dfs i j remaining)
    (if (or (< i 0) (>= i rows) (< j 0) (>= j cols))
        0
        (let ([cell (list-ref (list-ref grid i) j)])
          (cond
            [(= cell -1) 0]
            [(and (= i (car end)) (= j (cdr end)))
             (if (zero? remaining) 1 0)]
            [else
             (let ([original (list-ref (list-ref grid i) j)]
                   [count 0])
               (list-set! (list-ref grid i) j -1)
               (set! count (+ count (dfs (add1 i) j (sub1 remaining))))
               (set! count (+ count (dfs (sub1 i) j (sub1 remaining))))
               (set! count (+ count (dfs i (add1 j) (sub1 remaining))))
               (set! count (+ count (dfs i (sub1 j) (sub1 remaining))))
               (list-set! (list-ref grid i) j original)
               count)]))))

  (dfs (car start) (cdr start) (add1 empty)))