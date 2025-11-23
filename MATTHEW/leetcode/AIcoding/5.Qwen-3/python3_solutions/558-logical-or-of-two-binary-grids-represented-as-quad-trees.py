class Solution:
    def connect(self, quadTree1: 'Node', quadTree2: 'Node') -> 'Node':
        if not quadTree1:
            return quadTree2
        if not quadTree2:
            return quadTree1
        if quadTree1.isLeaf and quadTree1.val:
            return quadTree1
        if quadTree2.isLeaf and quadTree2.val:
            return quadTree2
        if quadTree1.isLeaf and not quadTree1.val:
            return quadTree2
        if quadTree2.isLeaf and not quadTree2.val:
            return quadTree1
        quadTree1.topLeft = self.connect(quadTree1.topLeft, quadTree2.topLeft)
        quadTree1.topRight = self.connect(quadTree1.topRight, quadTree2.topRight)
        quadTree1.bottomLeft = self.connect(quadTree1.bottomLeft, quadTree2.bottomLeft)
        quadTree1.bottomRight = self.connect(quadTree1.bottomRight, quadTree2.bottomRight)
        if (quadTree1.topLeft.isLeaf and quadTree1.topRight.isLeaf and 
            quadTree1.bottomLeft.isLeaf and quadTree1.bottomRight.isLeaf and 
            quadTree1.topLeft.val == quadTree1.topRight.val == quadTree1.bottomLeft.val == quadTree1.bottomRight.val):
            quadTree1.val = quadTree1.topLeft.val
            quadTree1.isLeaf = True
            quadTree1.topLeft = None
            quadTree1.topRight = None
            quadTree1.bottomLeft = None
            quadTree1.bottomRight = None
        return quadTree1