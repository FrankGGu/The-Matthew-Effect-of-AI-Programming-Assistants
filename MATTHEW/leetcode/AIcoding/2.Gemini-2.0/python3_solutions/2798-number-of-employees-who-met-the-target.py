class Solution:
    def numberOfEmployeesWhoMetTarget(self, hours: list[int], target: int) -> int:
        count = 0
        for hour in hours:
            if hour >= target:
                count += 1
        return count