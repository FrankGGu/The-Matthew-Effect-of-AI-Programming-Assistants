class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def reverseOddLevels(self, root: TreeNode) -> TreeNode:
        if not root:
            return root

        from collections import deque

        queue = deque([root])
        level = 0

        while queue:
            if level % 2 == 1:
                current_level = []
                for _ in range(len(queue)):
                    node = queue.popleft()
                    current_level.append(node.val)
                    if node.left:
                        queue.append(node.left)
                    if node.right:
                        queue.append(node.right)

                current_level.reverse()

                for i in range(len(current_level)):
                    node = queue[i] if i < len(queue) else None
                    if node:
                        node.val = current_level[i]

            else:
                for _ in range(len(queue)):
                    node = queue.popleft()
                    if node.left:
                        queue.append(node.left)
                    if node.right:
                        queue.append(node.right)

            level += 1

        return root