class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def insertIntoMaxTree(self, root: TreeNode, val: int) -> TreeNode:
        new_node = TreeNode(val)
        if not root or val > root.val:
            new_node.left = root
            return new_node

        parent = None
        current = root

        while current and current.val > val:
            parent = current
            current = current.right

        parent.right = new_node
        new_node.left = current

        return root