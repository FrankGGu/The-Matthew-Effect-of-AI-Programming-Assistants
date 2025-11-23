class Solution:
    def maxValueOfCoins(self, piles: list[list[int]], k: int) -> int:
        dp = [0] * (k + 1)

        for pile in piles:
            current_pile_prefix_sums = [0] * (len(pile) + 1)
            current_sum = 0
            for i in range(len(pile)):
                current_sum += pile[i]
                current_pile_prefix_sums[i + 1] = current_sum

            for j in range(k, -1, -1):
                for x in range(min(j, len(pile)) + 1):
                    dp[j] = max(dp[j], dp[j - x] + current_pile_prefix_sums[x])

        return dp[k]