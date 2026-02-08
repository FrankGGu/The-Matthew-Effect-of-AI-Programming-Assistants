class Solution:
    def pseudoPalindromicPaths (self, root: Optional[TreeNode]) -> int:
        def dfs(node, count):
            if not node:
                return 0
            count ^= 1 << (node.val - 1)
            if not node.left and not node.right:
                return 1 if (count & (count - 1)) == 0 else 0
            return dfs(node.left, count) + dfs(node.right, count)
        return dfs(root, 0)