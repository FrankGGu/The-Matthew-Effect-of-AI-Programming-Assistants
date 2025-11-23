#lang racket

(define-struct quad-tree (value is-leaf topLeft topRight bottomLeft bottomRight))

(define (intersect q1 q2)
  (if (and (quad-tree-is-leaf q1) (quad-tree-is-leaf q2))
      (make-quad-tree (or (quad-tree-value q1) (quad-tree-value q2)) #t #f #f #f #f)
      (if (quad-tree-is-leaf q1)
          (if (quad-tree-value q1)
              q1
              q2)
          (if (quad-tree-is-leaf q2)
              (if (quad-tree-value q2)
                  q2
                  q1)
              (let ([topLeft (intersect (quad-tree-topLeft q1) (quad-tree-topLeft q2))]
                    [topRight (intersect (quad-tree-topRight q1) (quad-tree-topRight q2))]
                    [bottomLeft (intersect (quad-tree-bottomLeft q1) (quad-tree-bottomLeft q2))]
                    [bottomRight (intersect (quad-tree-bottomRight q1) (quad-tree-bottomRight q2))])
                (if (and (quad-tree-is-leaf topLeft) (quad-tree-is-leaf topRight) (quad-tree-is-leaf bottomLeft) (quad-tree-is-leaf bottomRight)
                         (= (quad-tree-value topLeft) (quad-tree-value topRight)) (= (quad-tree-value topLeft) (quad-tree-value bottomLeft)) (= (quad-tree-value topLeft) (quad-tree-value bottomRight)))
                    (make-quad-tree (quad-tree-value topLeft) #t #f #f #f #f)
                    (make-quad-tree #f #f topLeft topRight bottomLeft bottomRight)))))))