from collections import deque

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def maxLevelSum(self, root: TreeNode) -> int:
        if not root:
            return 0

        q = deque([root])
        max_sum = float('-inf')
        max_level = 0
        level = 0

        while q:
            level += 1
            level_sum = 0
            level_size = len(q)

            for _ in range(level_size):
                node = q.popleft()
                level_sum += node.val

                if node.left:
                    q.append(node.left)
                if node.right:
                    q.append(node.right)

            if level_sum > max_sum:
                max_sum = level_sum
                max_level = level

        return max_level