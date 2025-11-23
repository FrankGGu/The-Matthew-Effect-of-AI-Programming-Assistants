(define (colorTree root color)
  (if (null? root)
      '()
      (let ((left (colorTree (car root) color))
            (right (colorTree (cadr root) color)))
        (cons (list (car root) color) (append left right)))))

(define (colorBinaryTree root color)
  (colorTree root color))