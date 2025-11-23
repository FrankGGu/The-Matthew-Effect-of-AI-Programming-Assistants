#lang racket

(define (recover-bst root)
  (define (inorder-traversal node)
    (if (not node)
        '()
        (append (inorder-traversal (node-left node))
                (list node)
                (inorder-traversal (node-right node)))))

  (define (swap a b)
    (let ((temp (node-val a)))
      (set-node-val! a (node-val b))
      (set-node-val! b temp)))

  (define (find-swapped nodes)
    (let loop ((i 0) (prev (car nodes)) (swapped '()))
      (if (>= i (- (length nodes) 1))
          swapped
          (let ((current (list-ref nodes (+ i 1))))
            (if (> (node-val prev) (node-val current))
                (loop (+ i 1) current (cons prev swapped))
                (loop (+ i 1) current swapped))))))

  (let* ((nodes (inorder-traversal root))
         (swapped (find-swapped nodes)))
    (if (= (length swapped) 2)
        (swap (car swapped) (cadr swapped))
        (swap (car swapped) (last swapped)))))