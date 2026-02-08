from collections import defaultdict

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findMode(self, root: TreeNode) -> list[int]:
        counts = defaultdict(int)

        def inorder(node):
            if not node:
                return
            inorder(node.left)
            counts[node.val] += 1
            inorder(node.right)

        inorder(root)

        max_count = 0
        for val in counts:
            max_count = max(max_count, counts[val])

        modes = []
        for val in counts:
            if counts[val] == max_count:
                modes.append(val)

        return modes