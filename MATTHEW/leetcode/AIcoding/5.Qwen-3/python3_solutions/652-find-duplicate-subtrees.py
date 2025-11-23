from collections import defaultdict
from typing import Optional, List

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findDuplicateSubtrees(self, root: Optional[TreeNode]) -> List[Optional[TreeNode]]:
        def serialize(node):
            if not node:
                return ""
            key = f"{node.val},{serialize(node.left)},{serialize(node.right)}"
            seen[key] += 1
            if seen[key] == 2:
                result.append(node)
            return key

        seen = defaultdict(int)
        result = []
        serialize(root)
        return result