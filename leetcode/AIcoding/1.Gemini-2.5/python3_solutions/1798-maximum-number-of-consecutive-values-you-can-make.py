class Solution:
    def getMaximumConsecutive(self, coins: list[int]) -> int:
        coins.sort()
        reachable = 0
        for coin in coins:
            if coin > reachable + 1:
                break
            reachable += coin
        return reachable + 1