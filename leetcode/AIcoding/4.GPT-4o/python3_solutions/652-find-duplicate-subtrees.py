class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findDuplicateSubtrees(self, root: TreeNode):
        from collections import defaultdict

        def serialize(node):
            if not node:
                return "#"
            serial = f"{node.val},{serialize(node.left)},{serialize(node.right)}"
            count[serial] += 1
            if count[serial] == 2:
                result.append(node)
            return serial

        count = defaultdict(int)
        result = []
        serialize(root)
        return result