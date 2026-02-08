class Solution:
    def reachNumber(self, target: int) -> int:
        target = abs(target)
        sum_steps = 0
        steps = 0

        while sum_steps < target or (sum_steps - target) % 2 != 0:
            steps += 1
            sum_steps += steps

        return steps