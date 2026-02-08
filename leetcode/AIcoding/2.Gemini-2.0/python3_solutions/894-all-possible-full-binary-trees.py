class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def allPossibleFBT(self, n: int) -> list[TreeNode | None]:
        if n % 2 == 0:
            return []

        memo = {}

        def generate(n):
            if n in memo:
                return memo[n]

            if n == 1:
                return [TreeNode()]

            res = []
            for i in range(1, n, 2):
                left_trees = generate(i)
                right_trees = generate(n - i - 1)

                for left in left_trees:
                    for right in right_trees:
                        root = TreeNode()
                        root.left = left
                        root.right = right
                        res.append(root)

            memo[n] = res
            return res

        return generate(n)