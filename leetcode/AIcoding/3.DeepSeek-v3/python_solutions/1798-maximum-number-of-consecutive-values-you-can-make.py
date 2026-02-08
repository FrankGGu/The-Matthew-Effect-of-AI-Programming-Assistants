class Solution:
    def getMaximumConsecutive(self, coins: List[int]) -> int:
        coins.sort()
        max_consec = 1
        for coin in coins:
            if coin > max_consec:
                break
            max_consec += coin
        return max_consec