class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def pseudoPalindromicPaths(self, root: TreeNode) -> int:
        def dfs(node, count):
            if not node:
                return 0

            count[node.val] ^= 1
            if not node.left and not node.right:
                return 1 if sum(count) <= 1 else 0

            left_paths = dfs(node.left, count)
            right_paths = dfs(node.right, count)

            count[node.val] ^= 1
            return left_paths + right_paths

        return dfs(root, [0] * 10)