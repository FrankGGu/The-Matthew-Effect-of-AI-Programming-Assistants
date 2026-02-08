class Solution:
    def __init__(self):
        self.current_sum = 0

    def bstToGst(self, root: TreeNode) -> TreeNode:
        if not root:
            return None

        # Traverse the right subtree first (reverse in-order)
        self.bstToGst(root.right)

        # Visit the current node: update sum and node's value
        self.current_sum += root.val
        root.val = self.current_sum

        # Traverse the left subtree
        self.bstToGst(root.left)

        return root