class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def tree2str(self, root: TreeNode) -> str:
        if not root:
            return ""
        s = str(root.val)
        if root.left:
            s += "(" + self.tree2str(root.left) + ")"
        else:
            if root.right:
                s += "()"
        if root.right:
            s += "(" + self.tree2str(root.right) + ")"
        return s