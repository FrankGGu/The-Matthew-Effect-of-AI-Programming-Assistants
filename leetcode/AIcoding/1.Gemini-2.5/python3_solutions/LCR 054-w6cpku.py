class Solution:
    def convertBST(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        self.current_sum = 0

        def dfs(node):
            if not node:
                return

            dfs(node.right)

            self.current_sum += node.val
            node.val = self.current_sum

            dfs(node.left)

        dfs(root)
        return root