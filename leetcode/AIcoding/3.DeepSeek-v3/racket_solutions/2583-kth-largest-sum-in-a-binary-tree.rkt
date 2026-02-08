#lang racket

(define (kth-largest-sum root k)
  (define (bfs queue sums)
    (if (null? queue)
        sums
        (let* ((level-sum (foldl + 0 (map car queue)))
               (next-queue (foldl (lambda (node acc)
                                    (let ((left (cadr node))
                                          (right (caddr node)))
                                      (append acc 
                                              (if left (list left) '())
                                              (if right (list right) '()))))
                                  '()
                                  queue)))
          (bfs next-queue (cons level-sum sums)))))
  (let ((sums (bfs (if root (list root) '()) '())))
    (if (< (length sums) k)
        -1
        (list-ref (sort sums >) (- k 1)))))