class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def trimBST(root: TreeNode, low: int, high: int) -> TreeNode:
    if not root:
        return None
    if root.val < low:
        return trimBST(root.right, low, high)
    if root.val > high:
        return trimBST(root.left, low, high)

    root.left = trimBST(root.left, low, high)
    root.right = trimBST(root.right, low, high)
    return root