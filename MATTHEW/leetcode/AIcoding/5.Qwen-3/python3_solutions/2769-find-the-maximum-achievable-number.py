class Solution:
    def theMaximumAchievableNumber(self, k: int, x: int) -> int:
        return k * (2 ** x) - k