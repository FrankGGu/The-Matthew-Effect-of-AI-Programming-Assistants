class Solution:
    def lcaDeepestLeaves(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        def dfs(node):
            if not node:
                return (None, 0)
            left, left_depth = dfs(node.left)
            right, right_depth = dfs(node.right)
            if left_depth > right_depth:
                return (left, left_depth + 1)
            elif right_depth > left_depth:
                return (right, right_depth + 1)
            else:
                return (node, left_depth + 1)

        result, _ = dfs(root)
        return result