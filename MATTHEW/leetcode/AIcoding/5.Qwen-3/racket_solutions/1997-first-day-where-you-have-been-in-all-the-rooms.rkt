#lang racket

(define (first-day-where-you-have-been-in-all-the-rooms visited)
  (define n (length visited))
  (define days (make-vector n 0))
  (define (dfs i)
    (if (>= i n) 0
        (let ([current (vector-ref days i)])
          (if (= current 0)
              (begin
                (vector-set! days i 1)
                (let ([res (dfs (+ i 1))])
                  (if (= res 0)
                      (vector-set! days i 2)
                      res)))
              (if (= current 1)
                  (begin
                    (vector-set! days i 2)
                    (dfs (+ i 1)))
                  0))))
  (let loop ([i 0] [res 0])
    (if (>= i n) res
        (let ([d (vector-ref days i)])
          (if (= d 0)
              (loop (+ i 1) res)
              (loop (+ i 1) (if (= d 2) (+ res 1) res)))))))