class Solution:
    def countPairs(self, root: TreeNode, distance: int) -> int:
        self.res = 0

        def dfs(node):
            if not node:
                return []
            if not node.left and not node.right:
                return [1]
            left = dfs(node.left)
            right = dfs(node.right)
            for l in left:
                for r in right:
                    if l + r <= distance:
                        self.res += 1
            return [n + 1 for n in left + right if n + 1 < distance]

        dfs(root)
        return self.res