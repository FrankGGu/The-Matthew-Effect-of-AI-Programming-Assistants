class Solution:
    def minimumAddedCoins(self, coins: List[int], target: int) -> int:
        coins.sort()
        res = 0
        current_max = 0
        i = 0
        n = len(coins)

        while current_max < target:
            if i < n and coins[i] <= current_max + 1:
                current_max += coins[i]
                i += 1
            else:
                res += 1
                current_max += current_max + 1

        return res