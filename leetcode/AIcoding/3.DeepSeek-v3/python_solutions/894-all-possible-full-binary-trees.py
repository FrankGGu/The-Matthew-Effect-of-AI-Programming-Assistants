class Solution:
    def allPossibleFBT(self, n: int) -> List[TreeNode]:
        if n % 2 == 0:
            return []

        memo = {}

        def helper(n):
            if n in memo:
                return memo[n]
            if n == 1:
                return [TreeNode(0)]

            res = []
            for i in range(1, n, 2):
                left = helper(i)
                right = helper(n - 1 - i)
                for l in left:
                    for r in right:
                        root = TreeNode(0)
                        root.left = l
                        root.right = r
                        res.append(root)
            memo[n] = res
            return res

        return helper(n)