#lang racket

(define (maximum-elegance scores)
  (define (cmp a b) (> (car a) (car b)))
  (define (sort-by-score lst) (sort lst cmp))
  (define (get-unique-count lst) (length (remove-duplicates (map car lst))))
  (define (get-max-elegance lst k)
    (let loop ([lst lst] [k k] [count 0] [unique 0] [res 0])
      (cond [(= k 0) res]
            [(null? lst) res]
            [else
             (let* ([current (car lst)]
                    [next (cdr lst)]
                    [score (car current)]
                    [type (cadr current)])
               (if (= count 0)
                   (loop next (- k 1) 1 unique (+ res score))
                   (if (and (>= count 1) (not (member type (map cadr (take lst (- k 1)))))) 
                       (loop next (- k 1) (+ count 1) (+ unique 1) (+ res score))
                       (loop next (- k 1) (+ count 1) unique (+ res score)))))])))
  (define sorted (sort-by-score (map (lambda (x) (list x (random))) scores)))
  (get-max-elegance sorted (length scores)))