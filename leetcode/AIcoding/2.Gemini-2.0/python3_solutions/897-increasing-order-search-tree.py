class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def increasingBST(self, root: TreeNode) -> TreeNode:
        def inorder(node):
            if not node:
                return []
            return inorder(node.left) + [node.val] + inorder(node.right)

        vals = inorder(root)

        if not vals:
            return None

        new_root = TreeNode(vals[0])
        curr = new_root

        for i in range(1, len(vals)):
            curr.right = TreeNode(vals[i])
            curr = curr.right

        return new_root