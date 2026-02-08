class Solution:
    def mirrorScore(self, s: str) -> int:
        score = 0
        for c in s:
            score += ord(c) - ord('a') + 1
        return score