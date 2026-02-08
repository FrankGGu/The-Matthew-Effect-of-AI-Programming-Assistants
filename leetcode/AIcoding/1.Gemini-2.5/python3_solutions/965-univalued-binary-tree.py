class Solution:
    def isUnivalTree(self, root: TreeNode) -> bool:
        if not root:
            return True

        univalue = root.val

        def dfs(node):
            if not node:
                return True

            if node.val != univalue:
                return False

            return dfs(node.left) and dfs(node.right)

        return dfs(root)