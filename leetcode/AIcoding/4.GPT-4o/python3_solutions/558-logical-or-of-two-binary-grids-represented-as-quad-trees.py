class Node:
    def __init__(self, val=True, isLeaf=False):
        self.val = val
        self.isLeaf = isLeaf

class Solution:
    def logicalOr(self, quadTree1: Node, quadTree2: Node) -> Node:
        if quadTree1.isLeaf:
            return Node(quadTree1.val or quadTree2.val, True)
        if quadTree2.isLeaf:
            return Node(quadTree1.val or quadTree2.val, True)

        topLeft = self.logicalOr(quadTree1.topLeft, quadTree2.topLeft)
        topRight = self.logicalOr(quadTree1.topRight, quadTree2.topRight)
        bottomLeft = self.logicalOr(quadTree1.bottomLeft, quadTree2.bottomLeft)
        bottomRight = self.logicalOr(quadTree1.bottomRight, quadTree2.bottomRight)

        if topLeft.isLeaf and topRight.isLeaf and bottomLeft.isLeaf and bottomRight.isLeaf:
            val = topLeft.val or topRight.val or bottomLeft.val or bottomRight.val
            return Node(val, True)

        return Node(False, False, topLeft, topRight, bottomLeft, bottomRight)