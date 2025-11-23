from collections import deque

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def widthOfBinaryTree(self, root: TreeNode) -> int:
        if not root:
            return 0

        queue = deque([(root, 0)])
        max_width = 0

        while queue:
            level_length = len(queue)
            leftmost = queue[0][1]
            rightmost = queue[-1][1]
            max_width = max(max_width, rightmost - leftmost + 1)

            for _ in range(level_length):
                node, position = queue.popleft()

                if node.left:
                    queue.append((node.left, 2 * position))
                if node.right:
                    queue.append((node.right, 2 * position + 1))

        return max_width