class Solution:
    def flatten(self, root: Optional[TreeNode]) -> None:
        """
        Do not return anything, modify root in-place instead.
        """
        if not root:
            return

        stack = [root]
        prev = None

        while stack:
            node = stack.pop()
            if prev:
                prev.left = None
                prev.right = node
            prev = node

            if node.right:
                stack.append(node.right)
            if node.left:
                stack.append(node.left)