class Solution:
    def taskSchedulerII(self, tasks: list[int], space: int) -> int:
        d = {}
        day = 0
        for task in tasks:
            day += 1
            if task in d and day <= d[task]:
                day = d[task] + 1
            d[task] = day + space
        return day