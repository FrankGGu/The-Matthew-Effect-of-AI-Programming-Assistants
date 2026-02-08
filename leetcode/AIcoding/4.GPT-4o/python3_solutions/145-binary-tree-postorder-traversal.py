class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def postorderTraversal(self, root: TreeNode) -> List[int]:
        res = []
        def traverse(node):
            if node:
                traverse(node.left)
                traverse(node.right)
                res.append(node.val)
        traverse(root)
        return res