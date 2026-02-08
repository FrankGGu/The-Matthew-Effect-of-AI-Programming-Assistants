class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def leafSimilar(root1: TreeNode, root2: TreeNode) -> bool:
    def getLeaves(node):
        if not node:
            return []
        if not node.left and not node.right:
            return [node.val]
        return getLeaves(node.left) + getLeaves(node.right)

    return getLeaves(root1) == getLeaves(root2)