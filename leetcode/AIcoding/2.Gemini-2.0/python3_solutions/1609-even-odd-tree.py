from collections import deque

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isEvenOddTree(self, root: TreeNode) -> bool:
        if not root:
            return True

        q = deque([root])
        level = 0

        while q:
            size = len(q)
            prev = -1 if level % 2 == 0 else float('inf')

            for _ in range(size):
                node = q.popleft()

                if level % 2 == 0:
                    if node.val % 2 == 0 or node.val <= prev:
                        return False
                    prev = node.val
                else:
                    if node.val % 2 != 0 or node.val >= prev:
                        return False
                    prev = node.val

                if node.left:
                    q.append(node.left)
                if node.right:
                    q.append(node.right)

            level += 1

        return True