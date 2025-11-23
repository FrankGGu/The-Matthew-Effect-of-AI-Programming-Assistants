from typing import List

class Solution:
    def maxScore(self, cardPoints: List[int], k: int) -> int:
        n = len(cardPoints)
        total = sum(cardPoints)
        windowSize = n - k
        current = sum(cardPoints[:windowSize])
        minSubarraySum = current
        for i in range(windowSize, n):
            current += cardPoints[i] - cardPoints[i - windowSize]
            minSubarraySum = min(minSubarraySum, current)
        return total - minSubarraySum