class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    def isSubStructure(self, A: TreeNode, B: TreeNode) -> bool:
        if not A or not B:
            return False

        return self._check(A, B) or \
               self.isSubStructure(A.left, B) or \
               self.isSubStructure(A.right, B)

    def _check(self, A: TreeNode, B: TreeNode) -> bool:
        if not B:
            return True

        if not A:
            return False

        if A.val != B.val:
            return False

        return self._check(A.left, B.left) and self._check(A.right, B.right)