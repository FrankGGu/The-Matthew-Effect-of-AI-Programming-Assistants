class Node:
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children if children is not None else []

def maxDepth(root: Node) -> int:
    if not root:
        return 0
    return 1 + max((maxDepth(child) for child in root.children), default=0)