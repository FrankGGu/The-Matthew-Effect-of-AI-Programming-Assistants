from collections import deque

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isCompleteTree(self, root: TreeNode) -> bool:
        if not root:
            return True

        queue = deque([root])
        flag = False

        while queue:
            node = queue.popleft()

            if not node:
                flag = True
            else:
                if flag:
                    return False
                queue.append(node.left)
                queue.append(node.right)

        return True