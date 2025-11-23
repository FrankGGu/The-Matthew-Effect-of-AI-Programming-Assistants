class Solution:
    def maxAncestorDiff(self, root: TreeNode) -> int:
        def dfs(node, min_val, max_val):
            if not node:
                return max_val - min_val
            new_min = min(min_val, node.val)
            new_max = max(max_val, node.val)
            left = dfs(node.left, new_min, new_max)
            right = dfs(node.right, new_min, new_max)
            return max(left, right)

        return dfs(root, root.val, root.val)