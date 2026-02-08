#lang racket

(define (find-minimum-diameter tree1 tree2)
  (define (get-diameter tree)
    (define (dfs node)
      (if (null? node)
          (cons 0 0)
          (let* ([left (dfs (car node))]
                 [right (dfs (cdr node))]
                 [height (add1 (max (car left) (car right)))]
                 [diameter (max (cdr left) (cdr right) (+ (car left) (car right)))])
            (cons height diameter))))
    (cdr (dfs tree)))

  (define (get-centers tree)
    (define (dfs node)
      (if (null? node)
          (list 0 '())
          (let* ([left (dfs (car node))]
                 [right (dfs (cdr node))]
                 [left-height (car left)]
                 [right-height (car right)]
                 [height (add1 (max left-height right-height))]
                 [path (if (> left-height right-height)
                           (map (lambda (x) (cons 'left x)) (cdr left))
                           (map (lambda (x) (cons 'right x)) (cdr right))])
            (cons height (cons node path)))))
    (define path (cdr (dfs tree)))
    (define len (length path))
    (if (even? len)
        (list (list-ref path (sub1 (quotient len 2))) (list-ref path (quotient len 2)))
        (list (list-ref path (quotient len 2)))))

  (define centers1 (get-centers tree1))
  (define centers2 (get-centers tree2))
  (define diameters (list (get-diameter tree1) (get-diameter tree2)))

  (define min-diameter +inf.0)
  (for ([c1 centers1])
    (for ([c2 centers2])
      (define new-tree (cons c1 (cons c2 '())))
      (define new-diameter (get-diameter new-tree))
      (set! min-diameter (min min-diameter new-diameter (max (car diameters) (cadr diameters))))))

  (inexact->exact (floor min-diameter)))