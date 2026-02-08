class Solution:
    def maxValue(self, root: TreeNode, k: int) -> int:
        def dfs(node):
            if not node:
                return [0] * (k + 1)
            left = dfs(node.left)
            right = dfs(node.right)
            res = [0] * (k + 1)
            for l in range(k + 1):
                for r in range(k + 1):
                    if l + r < k:
                        res[l + r + 1] = max(res[l + r + 1], left[l] + right[r] + node.val)
                    res[0] = max(res[0], left[l] + right[r])
            return res
        return max(dfs(root))