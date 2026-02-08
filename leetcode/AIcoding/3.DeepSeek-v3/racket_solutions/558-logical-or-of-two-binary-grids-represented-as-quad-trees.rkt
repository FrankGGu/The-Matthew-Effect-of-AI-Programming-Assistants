#|
# Definition for a QuadTree node.
# class Node:
#     def __init__(self, val, isLeaf, topLeft, topRight, bottomLeft, bottomRight):
#         self.val = val
#         self.isLeaf = isLeaf
#         self.topLeft = topLeft
#         self.topRight = topRight
#         self.bottomLeft = bottomLeft
#         self.bottomRight = bottomRight
|#

(define (intersect quadTree1 quadTree2)
  (cond
    [(and (node-isLeaf quadTree1) (node-isLeaf quadTree2))
     (node (or (node-val quadTree1) (node-val quadTree2)) #t #f #f #f #f)]
    [(node-isLeaf quadTree1)
     (if (node-val quadTree1)
         (node #t #t #f #f #f #f)
         quadTree2)]
    [(node-isLeaf quadTree2)
     (if (node-val quadTree2)
         (node #t #t #f #f #f #f)
         quadTree1)]
    [else
     (let ([topLeft (intersect (node-topLeft quadTree1) (node-topLeft quadTree2))]
           [topRight (intersect (node-topRight quadTree1) (node-topRight quadTree2))]
           [bottomLeft (intersect (node-bottomLeft quadTree1) (node-bottomLeft quadTree2))]
           [bottomRight (intersect (node-bottomRight quadTree1) (node-bottomRight quadTree2))])
       (if (and (node-isLeaf topLeft)
                (node-isLeaf topRight)
                (node-isLeaf bottomLeft)
                (node-isLeaf bottomRight)
                (equal? (node-val topLeft) (node-val topRight))
                (equal? (node-val topLeft) (node-val bottomLeft))
                (equal? (node-val topLeft) (node-val bottomRight)))
           (node (node-val topLeft) #t #f #f #f #f)
           (node #f #f topLeft topRight bottomLeft bottomRight)))]))