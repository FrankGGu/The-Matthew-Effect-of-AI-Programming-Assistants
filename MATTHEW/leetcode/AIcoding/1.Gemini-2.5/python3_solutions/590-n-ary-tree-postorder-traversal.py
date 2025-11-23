"""
class Node:
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children if children is not None else []
"""

from typing import List

class Solution:
    def postorder(self, root: 'Node') -> List[int]:
        result = []
        if not root:
            return result

        for child in root.children:
            result.extend(self.postorder(child))

        result.append(root.val)
        return result