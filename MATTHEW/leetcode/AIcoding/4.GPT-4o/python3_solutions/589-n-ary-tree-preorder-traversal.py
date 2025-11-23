class Node:
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children if children is not None else []

class Solution:
    def preorder(self, root: Node) -> List[int]:
        result = []
        self._preorder_helper(root, result)
        return result

    def _preorder_helper(self, node: Node, result: List[int]):
        if not node:
            return
        result.append(node.val)
        for child in node.children:
            self._preorder_helper(child, result)