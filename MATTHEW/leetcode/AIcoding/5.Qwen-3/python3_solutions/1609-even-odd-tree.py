class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isEvenOddTree(self, root: TreeNode) -> bool:
        from collections import deque

        queue = deque([(root, 0)])
        prev_level = -1
        prev_val = None

        while queue:
            node, level = queue.popleft()
            if level != prev_level:
                prev_level = level
                prev_val = node.val
                if level % 2 == 0:
                    if node.val % 2 == 0:
                        return False
                else:
                    if node.val % 2 == 1:
                        return False
            else:
                if level % 2 == 0:
                    if node.val % 2 == 0 or node.val <= prev_val:
                        return False
                else:
                    if node.val % 2 == 1 or node.val >= prev_val:
                        return False
                prev_val = node.val

            if node.left:
                queue.append((node.left, level + 1))
            if node.right:
                queue.append((node.right, level + 1))

        return True