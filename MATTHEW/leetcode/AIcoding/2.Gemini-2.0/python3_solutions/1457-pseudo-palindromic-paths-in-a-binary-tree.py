class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def pseudoPalindromicPaths(self, root: TreeNode) -> int:
        count = 0
        def dfs(node, path):
            nonlocal count
            if not node:
                return

            path[node.val] += 1

            if not node.left and not node.right:
                odd_count = 0
                for val in path:
                    if path[val] % 2 != 0:
                        odd_count += 1
                if odd_count <= 1:
                    count += 1
            else:
                dfs(node.left, path.copy())
                dfs(node.right, path.copy())

        dfs(root, [0] * 10)
        return count