#lang racket

(define (path-in-zigzag-tree label)
  (let loop ((current-label label)
             (path '()))
    (if (= current-label 0)
        path
        (let* ((l (add1 (floor (log current-label 2))))
               (min-l (expt 2 (sub1 l)))
               (max-l (sub1 (expt 2 l)))
               (mirror-label (+ min-l max-l (- current-label)))
               (parent (floor (/ mirror-label 2))))
          (loop parent (cons current-label path))))))