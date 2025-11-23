from collections import defaultdict

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def replaceValueInTree(self, root: TreeNode) -> TreeNode:
        level_sums = defaultdict(int)
        q = [(root, 0)]

        while q:
            next_q = []

            for node, level in q:
                level_sums[level] += node.val

                if node.left:
                    next_q.append((node.left, level + 1))
                if node.right:
                    next_q.append((node.right, level + 1))

            q = next_q

        q = [(root, 0, 0)]
        root.val = 0

        while q:
            next_q = []

            for node, level, parent_sum in q:
                children_sum = 0
                if node.left:
                    children_sum += node.left.val
                if node.right:
                    children_sum += node.right.val

                if node.left:
                    node.left.val = level_sums[level + 1] - node.left.val - (node.right.val if node.right else 0)
                    next_q.append((node.left, level + 1, children_sum))
                if node.right:
                    node.right.val = level_sums[level + 1] - node.right.val - (node.left.val if node.left else 0)
                    next_q.append((node.right, level + 1, children_sum))

            q = next_q

        return root