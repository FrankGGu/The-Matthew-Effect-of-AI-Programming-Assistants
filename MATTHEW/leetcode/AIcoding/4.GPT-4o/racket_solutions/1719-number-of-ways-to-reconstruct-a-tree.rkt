#lang racket

(define (check-ways pre post)
  (define n (length pre))
  (define (helper pre post)
    (if (or (null? pre) (null? post))
        (if (and (null? pre) (null? post)) 1 0)
        (let ((root (car pre)))
          (define left-subtree (take-while (lambda (x) (< x root)) (cdr pre)))
          (define right-subtree (drop-while (lambda (x) (< x root)) (cdr pre)))
          (define left-count (length left-subtree))
          (define right-count (length right-subtree))
          (define left-post (take left-count post))
          (define right-post (drop left-count post))
          (if (equal? (append left-post right-post) (cdr post))
              (* (helper left-subtree left-post)
                 (helper right-subtree right-post)
                 (choose (+ left-count right-count) left-count))
              0)))))
  (define (choose n k)
    (if (< k 0) 0
        (if (= k 0) 1
            (/ (* (apply * (range (- n 1) n))
                  (apply * (range 1 (add1 k))))
               (apply * (range 1 (add1 (- n k))))))))
  (helper pre post))

(define (numOfWays pre post)
  (check-ways pre post))