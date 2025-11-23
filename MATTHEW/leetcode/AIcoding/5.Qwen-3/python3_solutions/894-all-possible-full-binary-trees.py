class Solution:
    def allPossibleFBT(self, n: int) -> List[TreeNode]:
        from collections import defaultdict

        memo = defaultdict(list)

        def dfs(n):
            if n == 1:
                return [TreeNode(0)]
            if n in memo:
                return memo[n]
            res = []
            for i in range(1, n, 2):
                left = dfs(i)
                right = dfs(n - 1 - i)
                for l in left:
                    for r in right:
                        root = TreeNode(0)
                        root.left = l
                        root.right = r
                        res.append(root)
            memo[n] = res
            return res

        return dfs(n)