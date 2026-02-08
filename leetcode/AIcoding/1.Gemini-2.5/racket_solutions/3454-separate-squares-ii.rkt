#lang racket

(define (is-perfect-square n)
  (if (< n 0)
      #f
      (let* ((root (exact-floor (sqrt n))))
        (= (* root root) n))))

(define (separate-squares-ii nums)
  (let loop ((remaining nums)
             (squares '())
             (non-squares '()))
    (if (empty? remaining)
        (list (reverse squares) (reverse non-squares))
        (let ((num (car remaining)))
          (if (is-perfect-square num)
              (loop (cdr remaining) (cons num squares) non-squares)
              (loop (cdr remaining) squares (cons num non-squares)))))))