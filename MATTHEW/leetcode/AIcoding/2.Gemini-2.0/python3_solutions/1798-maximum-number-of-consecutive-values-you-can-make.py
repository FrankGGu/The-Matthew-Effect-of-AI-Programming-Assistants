class Solution:
    def getMaximumConsecutive(self, coins: List[int]) -> int:
        coins.sort()
        res = 1
        for coin in coins:
            if coin <= res:
                res += coin
            else:
                break
        return res