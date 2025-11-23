class Solution:
    def canIWin(self, maxChoosableInteger: int, desiredTotal: int) -> bool:
        if desiredTotal <= 0:
            return True
        if (1 + maxChoosableInteger) * maxChoosableInteger // 2 < desiredTotal:
            return False

        memo = {}

        def canWin(remainingTotal, used):
            if remainingTotal <= 0:
                return False
            if used in memo:
                return memo[used]

            for i in range(maxChoosableInteger):
                if (used & (1 << i)) == 0:
                    if not canWin(remainingTotal - (i + 1), used | (1 << i)):
                        memo[used] = True
                        return True

            memo[used] = False
            return False

        return canWin(desiredTotal, 0)