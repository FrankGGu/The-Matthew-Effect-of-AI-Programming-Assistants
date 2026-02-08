class Solution:
    def trainingPlan(self, actions: List[int]) -> int:
        ones, twos = 0, 0
        for num in actions:
            ones = (ones ^ num) & ~twos
            twos = (twos ^ num) & ~ones
        return ones