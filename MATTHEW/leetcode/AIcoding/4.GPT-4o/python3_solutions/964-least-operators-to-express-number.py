class Solution:
    def leastOpsExpressTarget(self, x: int, target: int) -> int:
        if target == 0:
            return 0
        if target == 1:
            return 1

        def helper(x, target):
            if target == 0:
                return float('inf')
            if target == 1:
                return 1
            if target < 0:
                return float('inf')

            a, b = divmod(target, x)
            if b == 0:
                return a - 1
            else:
                return a + 1 + min(helper(x, b), helper(x, x - b)) 

        return helper(x, target)