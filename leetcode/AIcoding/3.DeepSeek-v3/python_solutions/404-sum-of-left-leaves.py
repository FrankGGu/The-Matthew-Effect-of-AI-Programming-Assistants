class Solution:
    def sumOfLeftLeaves(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        stack = [(root, False)]
        total = 0

        while stack:
            node, is_left = stack.pop()
            if not node.left and not node.right and is_left:
                total += node.val
            if node.right:
                stack.append((node.right, False))
            if node.left:
                stack.append((node.left, True))

        return total