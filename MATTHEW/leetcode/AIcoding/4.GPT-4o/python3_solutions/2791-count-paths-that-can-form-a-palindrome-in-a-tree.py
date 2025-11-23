class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def countPalindromicPaths(self, root: TreeNode) -> int:
        def dfs(node, count):
            if not node:
                return 0
            count[node.val] += 1
            if not node.left and not node.right:
                odd_count = sum(1 for v in count if v % 2 != 0)
                result = 1 if odd_count <= 1 else 0
            else:
                result = dfs(node.left, count) + dfs(node.right, count)
            count[node.val] -= 1
            return result

        return dfs(root, [0]*10)