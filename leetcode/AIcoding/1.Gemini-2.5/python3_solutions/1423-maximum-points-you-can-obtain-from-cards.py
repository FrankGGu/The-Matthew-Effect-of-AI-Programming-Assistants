class Solution:
    def maxScore(self, cardPoints: list[int], k: int) -> int:
        n = len(cardPoints)

        current_sum = sum(cardPoints[:k])
        max_score = current_sum

        for i in range(1, k + 1):
            # Remove the (k-i)-th card from the left segment
            # Add the i-th card from the right end of the array
            current_sum = current_sum - cardPoints[k - i] + cardPoints[n - i]
            max_score = max(max_score, current_sum)

        return max_score