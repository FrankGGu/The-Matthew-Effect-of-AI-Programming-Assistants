class Solution:
    def maxCoins(self, bags: list[int], k: int) -> int:
        n = len(bags)

        if n < k:
            return 0

        current_sum = sum(bags[:k])
        max_sum = current_sum

        for i in range(k, n):
            current_sum += bags[i] - bags[i - k]
            max_sum = max(max_sum, current_sum)

        return max_sum