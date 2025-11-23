class Solution:
    def rob(self, root: TreeNode) -> int:
        def helper(node):
            if not node:
                return (0, 0)
            left = helper(node.left)
            right = helper(node.right)
            steal = node.val + left[0] + right[0]
            not_steal = max(left[1], left[0]) + max(right[1], right[0])
            return (steal, not_steal)

        return max(helper(root))