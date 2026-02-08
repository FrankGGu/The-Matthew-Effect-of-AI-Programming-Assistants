class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def largestValues(self, root: TreeNode) -> List[int]:
        if not root:
            return []
        result = []
        queue = [root]
        while queue:
            max_value = float('-inf')
            next_queue = []
            for node in queue:
                max_value = max(max_value, node.val)
                if node.left:
                    next_queue.append(node.left)
                if node.right:
                    next_queue.append(node.right)
            result.append(max_value)
            queue = next_queue
        return result