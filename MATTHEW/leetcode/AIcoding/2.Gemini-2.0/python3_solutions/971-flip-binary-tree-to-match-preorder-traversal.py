class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def flipMatchVoyage(self, root: TreeNode, voyage: list[int]) -> list[int]:
        flipped = []
        i = 0

        def traverse(node):
            nonlocal i, flipped
            if not node:
                return True

            if node.val != voyage[i]:
                return False

            i += 1

            if node.left and node.left.val != voyage[i]:
                flipped.append(node.val)
                node.left, node.right = node.right, node.left

            if not traverse(node.left):
                return False

            if not traverse(node.right):
                return False

            return True

        if traverse(root):
            return flipped
        else:
            return [-1]