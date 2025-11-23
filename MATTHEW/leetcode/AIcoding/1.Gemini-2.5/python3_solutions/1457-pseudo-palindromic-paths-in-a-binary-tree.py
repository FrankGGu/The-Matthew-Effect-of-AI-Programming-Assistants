class Solution:
    def pseudoPalindromicPaths (self, root: TreeNode) -> int:
        self.count = 0

        def dfs(node, path_mask):
            if not node:
                return

            path_mask ^= (1 << node.val)

            if not node.left and not node.right:
                if (path_mask & (path_mask - 1)) == 0:
                    self.count += 1
                return

            dfs(node.left, path_mask)
            dfs(node.right, path_mask)

        dfs(root, 0)
        return self.count