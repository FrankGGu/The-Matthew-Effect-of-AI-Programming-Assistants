class Solution:
    def findSecondMinimumValue(self, root: Optional[TreeNode]) -> int:
        min1 = root.val
        min2_candidate = float('inf')

        def dfs(node):
            nonlocal min2_candidate
            if not node:
                return

            if node.val > min1:
                min2_candidate = min(min2_candidate, node.val)
                return

            if node.val == min1:
                dfs(node.left)
                dfs(node.right)

        dfs(root)

        return min2_candidate if min2_candidate != float('inf') else -1