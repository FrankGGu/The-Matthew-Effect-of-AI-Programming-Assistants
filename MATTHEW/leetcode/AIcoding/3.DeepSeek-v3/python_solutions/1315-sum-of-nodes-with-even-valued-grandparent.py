class Solution:
    def sumEvenGrandparent(self, root: TreeNode) -> int:
        self.total = 0

        def dfs(node, parent, grandparent):
            if not node:
                return
            if grandparent and grandparent.val % 2 == 0:
                self.total += node.val
            dfs(node.left, node, parent)
            dfs(node.right, node, parent)

        dfs(root, None, None)
        return self.total