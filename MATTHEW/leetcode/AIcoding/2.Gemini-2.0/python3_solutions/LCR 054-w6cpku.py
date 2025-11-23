class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def convertBST(self, root: TreeNode) -> TreeNode:
        self.sum = 0

        def inorder_reverse(node):
            if not node:
                return

            inorder_reverse(node.right)
            self.sum += node.val
            node.val = self.sum
            inorder_reverse(node.left)

        inorder_reverse(root)
        return root