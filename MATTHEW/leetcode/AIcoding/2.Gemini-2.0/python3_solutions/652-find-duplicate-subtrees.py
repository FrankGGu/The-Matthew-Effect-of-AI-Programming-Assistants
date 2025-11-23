from collections import defaultdict

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findDuplicateSubtrees(self, root: TreeNode) -> list[TreeNode]:
        count = defaultdict(int)
        res = []

        def dfs(node):
            if not node:
                return '#'

            subtree = str(node.val) + ',' + dfs(node.left) + ',' + dfs(node.right)

            count[subtree] += 1
            if count[subtree] == 2:
                res.append(node)

            return subtree

        dfs(root)
        return res