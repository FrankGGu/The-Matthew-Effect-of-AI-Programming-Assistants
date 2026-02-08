class Solution:
    def maxScore(self, s: str) -> int:
        n = len(s)
        max_score = 0
        for i in range(1, n):
            left = s[:i]
            right = s[i:]
            score = left.count('0') + right.count('1')
            max_score = max(max_score, score)
        return max_score