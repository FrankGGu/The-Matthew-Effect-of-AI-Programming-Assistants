class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def __init__(self):
        self.unique_values = set()

    def lightUp(self, root: TreeNode) -> int:
        self.unique_values = set()
        self.traverse(root)
        return len(self.unique_values)

    def traverse(self, node: TreeNode):
        if not node:
            return
        self.unique_values.add(node.val)
        self.traverse(node.left)
        self.traverse(node.right)