class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def lightUp(self, root: TreeNode) -> int:
        self.ans = 0

        def dfs(node):
            if not node:
                return 0

            left = dfs(node.left)
            right = dfs(node.right)

            if left == 0 and right == 0:
                return 0
            elif left == 0 and right == 1:
                return 0
            elif left == 1 and right == 0:
                return 0
            elif left == 1 and right == 1:
                return 0
            elif left == 0 and right == 2:
                self.ans += 1
                return 1
            elif left == 2 and right == 0:
                self.ans += 1
                return 1
            elif left == 1 and right == 2:
                self.ans += 1
                return 1
            elif left == 2 and right == 1:
                self.ans += 1
                return 1
            else:
                return 2

        if dfs(root) == 0:
            self.ans += 1

        return self.ans