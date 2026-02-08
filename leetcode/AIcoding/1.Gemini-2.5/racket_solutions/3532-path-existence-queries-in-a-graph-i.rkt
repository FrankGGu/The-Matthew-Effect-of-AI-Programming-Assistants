#lang racket

(define (path-queries n edges queries)
  (let* ((parent (make-vector n 0))
         (find (lambda (i)
                 (let loop ((curr i))
                   (let ((p (vector-ref parent curr)))
                     (if (= p curr)
                         curr
                         (let ((root (loop p)))
                           (vector-set! parent curr root)
                           root))))))
         (union (lambda (i j)
                  (let ((root-i (find i))
                        (root-j (find j)))
                    (unless (= root-i root-j)
                      (vector-set! parent root-i root-j))))))

    (for ((i (in-range n)))
      (vector-set! parent i i))

    (for-each (lambda (edge)
                (union (car edge) (cadr edge)))
              edges)

    (map (lambda (query)
           (= (find (car query)) (find (cadr query))))
         queries)))