class Solution:
    def maxAncestorDiff(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        def dfs(node, current_max, current_min):
            if not node:
                return current_max - current_min

            current_max = max(current_max, node.val)
            current_min = min(current_min, node.val)

            left_diff = dfs(node.left, current_max, current_min)
            right_diff = dfs(node.right, current_max, current_min)

            return max(left_diff, right_diff)

        return dfs(root, root.val, root.val)