class Solution:
    def numColor(self, root: TreeNode) -> int:
        colors = set()

        def dfs(node):
            if not node:
                return
            colors.add(node.val)
            dfs(node.left)
            dfs(node.right)

        dfs(root)
        return len(colors)