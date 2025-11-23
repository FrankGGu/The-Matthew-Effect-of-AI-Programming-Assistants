class Solution:
    def sufficientSubset(self, root: TreeNode, limit: int) -> TreeNode:
        def dfs(node, current_sum):
            if not node:
                return False
            current_sum += node.val
            if not node.left and not node.right:
                return current_sum >= limit
            left = dfs(node.left, current_sum)
            right = dfs(node.right, current_sum)
            if not left:
                node.left = None
            if not right:
                node.right = None
            return left or right
        return root if dfs(root, 0) else None