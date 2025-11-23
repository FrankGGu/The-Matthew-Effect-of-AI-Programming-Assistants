from collections import deque

class Solution:
    def isEvenOddTree(self, root: Optional[TreeNode]) -> bool:
        if not root:
            return True

        queue = deque([root])
        level = 0

        while queue:
            level_size = len(queue)
            prev_val = None

            for i in range(level_size):
                node = queue.popleft()

                # Check current node's value
                if level % 2 == 0:  # Even level
                    if node.val % 2 == 0:
                        return False
                    if prev_val is not None and node.val <= prev_val:
                        return False
                else:  # Odd level
                    if node.val % 2 != 0:
                        return False
                    if prev_val is not None and node.val >= prev_val:
                        return False

                prev_val = node.val

                # Add children to the queue
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            level += 1

        return True