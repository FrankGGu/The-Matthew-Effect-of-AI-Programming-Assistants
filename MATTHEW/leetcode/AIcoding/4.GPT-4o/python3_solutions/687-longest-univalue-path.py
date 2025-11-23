class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def longestUnivaluePath(self, root: TreeNode) -> int:
        self.max_length = 0

        def dfs(node):
            if not node:
                return 0

            left_length = dfs(node.left)
            right_length = dfs(node.right)
            left_path = right_path = 0

            if node.left and node.left.val == node.val:
                left_path = left_length + 1
            if node.right and node.right.val == node.val:
                right_path = right_length + 1

            self.max_length = max(self.max_length, left_path + right_path)
            return max(left_path, right_path)

        dfs(root)
        return self.max_length