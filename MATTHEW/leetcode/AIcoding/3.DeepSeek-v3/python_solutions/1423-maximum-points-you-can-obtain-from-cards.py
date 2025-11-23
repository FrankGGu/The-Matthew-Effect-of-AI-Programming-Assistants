class Solution:
    def maxScore(self, cardPoints: List[int], k: int) -> int:
        n = len(cardPoints)
        total = sum(cardPoints)
        if k == n:
            return total

        window_size = n - k
        window_sum = sum(cardPoints[:window_size])
        min_sum = window_sum

        for i in range(1, k + 1):
            window_sum = window_sum - cardPoints[i - 1] + cardPoints[i + window_size - 1]
            min_sum = min(min_sum, window_sum)

        return total - min_sum