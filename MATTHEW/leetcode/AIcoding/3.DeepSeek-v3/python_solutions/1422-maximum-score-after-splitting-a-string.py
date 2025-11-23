class Solution:
    def maxScore(self, s: str) -> int:
        max_score = 0
        for i in range(1, len(s)):
            left = s[:i].count('0')
            right = s[i:].count('1')
            current_score = left + right
            if current_score > max_score:
                max_score = current_score
        return max_score