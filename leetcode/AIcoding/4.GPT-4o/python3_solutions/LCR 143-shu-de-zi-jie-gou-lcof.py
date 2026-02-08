class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isSubStructure(self, A: TreeNode, B: TreeNode) -> bool:
        if not A or not B:
            return False

        def match(A, B):
            if not B:
                return True
            if not A or A.val != B.val:
                return False
            return match(A.left, B.left) and match(A.right, B.right)

        return match(A, B) or self.isSubStructure(A.left, B) or self.isSubStructure(A.right, B)