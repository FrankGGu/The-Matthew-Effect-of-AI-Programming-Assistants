class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def minDiffInBST(self, root: TreeNode) -> int:
        nodes = []
        def inorder(node):
            if node:
                inorder(node.left)
                nodes.append(node.val)
                inorder(node.right)
        inorder(root)
        min_diff = float('inf')
        for i in range(1, len(nodes)):
            min_diff = min(min_diff, nodes[i] - nodes[i-1])
        return min_diff