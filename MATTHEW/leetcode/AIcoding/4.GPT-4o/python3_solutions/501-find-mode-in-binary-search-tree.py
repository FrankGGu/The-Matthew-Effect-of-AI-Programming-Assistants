class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findMode(self, root: TreeNode) -> List[int]:
        from collections import defaultdict

        count = defaultdict(int)
        max_count = 0

        def inorder(node):
            nonlocal max_count
            if not node:
                return
            inorder(node.left)
            count[node.val] += 1
            max_count = max(max_count, count[node.val])
            inorder(node.right)

        inorder(root)
        return [key for key, val in count.items() if val == max_count]