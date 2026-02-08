class Node:
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children if children is not None else []

class Solution:
    def postorder(self, root: 'Node') -> List[int]:
        res = []
        def traverse(node):
            if node:
                for child in node.children:
                    traverse(child)
                res.append(node.val)
        traverse(root)
        return res