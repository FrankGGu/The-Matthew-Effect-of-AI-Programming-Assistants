class Solution:
    def taskSchedulerII(self, tasks: List[int], space: int) -> int:
        last_day = {}
        current_day = 0

        for task in tasks:
            current_day += 1
            if task in last_day:
                if current_day - last_day[task] <= space:
                    current_day = last_day[task] + space + 1
            last_day[task] = current_day

        return current_day