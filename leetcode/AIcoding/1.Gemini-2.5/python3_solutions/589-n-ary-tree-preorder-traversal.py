"""
class Node:
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children
"""

class Solution:
    def preorder(self, root: 'Node') -> list[int]:
        result = []
        if not root:
            return result

        stack = [root]

        while stack:
            node = stack.pop()
            result.append(node.val)

            if node.children:
                # Push children onto the stack in reverse order
                # so that the left-most child is processed first (LIFO)
                for child in reversed(node.children):
                    stack.append(child)

        return result