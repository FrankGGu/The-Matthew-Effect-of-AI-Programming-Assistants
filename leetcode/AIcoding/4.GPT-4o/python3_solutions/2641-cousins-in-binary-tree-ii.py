class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def replaceValueInTree(self, root: TreeNode) -> TreeNode:
        if not root:
            return None

        from collections import deque

        queue = deque([root])

        while queue:
            level_size = len(queue)
            level_sum = 0
            nodes = []

            for _ in range(level_size):
                node = queue.popleft()
                level_sum += node.val
                nodes.append(node)
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            for node in nodes:
                node.val = level_sum - node.val

        return root