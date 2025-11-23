#lang racket

(define (count-paths root)
  (define (dfs node parent)
    (if (not node)
        '()
        (let* ([left (dfs (car node) (cadr node))]
               [right (dfs (caddr node) (cadddr node))]
               [sum (cons (car node) (append left right))])
          sum)))
  (let ([paths (dfs root #f)])
    (for/fold ([max 0]) ([p paths])
      (max max (apply + p)))))

(define (main)
  (define input (read))
  (displayln (count-paths input)))

(main)