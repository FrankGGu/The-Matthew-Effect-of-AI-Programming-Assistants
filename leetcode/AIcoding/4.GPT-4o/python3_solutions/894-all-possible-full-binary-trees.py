class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def allPossibleFBT(n: int):
    if n % 2 == 0:
        return []
    if n == 1:
        return [TreeNode(0)]

    result = []
    for left in range(1, n, 2):
        right = n - 1 - left
        for l in allPossibleFBT(left):
            for r in allPossibleFBT(right):
                root = TreeNode(0)
                root.left = l
                root.right = r
                result.append(root)

    return result