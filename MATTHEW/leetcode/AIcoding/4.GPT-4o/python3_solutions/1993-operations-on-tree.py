class Node:
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children if children is not None else []

class Solution:
    def sum(self, root: Node) -> int:
        if not root:
            return 0
        total = root.val
        for child in root.children:
            total += self.sum(child)
        return total

    def maxDepth(self, root: Node) -> int:
        if not root:
            return 0
        if not root.children:
            return 1
        return 1 + max(self.maxDepth(child) for child in root.children)

    def countNodes(self, root: Node) -> int:
        if not root:
            return 0
        count = 1
        for child in root.children:
            count += self.countNodes(child)
        return count