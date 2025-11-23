class Solution:
    def isSubStructure(self, A: TreeNode, B: TreeNode) -> bool:
        def dfs(a, b):
            if not b:
                return True
            if not a or a.val != b.val:
                return False
            return dfs(a.left, b.left) and dfs(a.right, b.right)

        if not A or not B:
            return False

        return dfs(A, B) or self.isSubStructure(A.left, B) or self.isSubStructure(A.right, B)