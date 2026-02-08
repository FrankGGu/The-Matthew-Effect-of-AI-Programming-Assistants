class Solution:
    def canIWin(self, maxChoosableInteger: int, desiredTotal: int) -> bool:
        if maxChoosableInteger >= desiredTotal:
            return True
        if (maxChoosableInteger + 1) * maxChoosableInteger // 2 < desiredTotal:
            return False

        memo = {}

        def dfs(used, remaining):
            if remaining <= 0:
                return False
            if used in memo:
                return memo[used]

            for i in range(1, maxChoosableInteger + 1):
                mask = 1 << i
                if not (used & mask):
                    if not dfs(used | mask, remaining - i):
                        memo[used] = True
                        return True
            memo[used] = False
            return False

        return dfs(0, desiredTotal)