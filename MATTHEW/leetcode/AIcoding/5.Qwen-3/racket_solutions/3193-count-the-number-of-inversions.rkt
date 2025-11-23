#lang racket

(define (count-inversions nums)
  (define (merge-sort-and-count arr)
    (define (merge left right)
      (let loop ([left left] [right right] [result '()] [count 0])
        (cond [(null? left) (values result count)]
              [(null? right) (values result count)]
              [(<= (car left) (car right))
               (loop (cdr left) right (cons (car left) result) count)]
              [else
               (loop left (cdr right) (cons (car right) result) (+ count (length left)))])))
    (define (split lst)
      (let loop ([lst lst] [left '()] [right '()])
        (if (null? lst)
            (values left right)
            (loop (cdr lst) (cons (car lst) left) right))))
    (if (<= (length arr) 1)
        (values arr 0)
        (let* ([mid (quotient (length arr) 2)]
               [left (take arr mid)]
               [right (drop arr mid)]
               [left-sorted left-count]
               [right-sorted right-count]
               [merged (merge left-sorted right-sorted)])
          (values (car merged) (+ left-count right-count (cadr merged))))))
  (define-values (sorted count) (merge-sort-and-count nums))
  count)