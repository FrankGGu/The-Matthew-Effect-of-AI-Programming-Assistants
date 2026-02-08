class Solution:
    def maxRunTime(self, n: int, batteries: list[int]) -> int:
        batteries.sort()
        total_power = sum(batteries)

        while batteries[-1] > total_power // n:
            total_power -= batteries[-1]
            n -= 1
            batteries.pop()

        return total_power // n