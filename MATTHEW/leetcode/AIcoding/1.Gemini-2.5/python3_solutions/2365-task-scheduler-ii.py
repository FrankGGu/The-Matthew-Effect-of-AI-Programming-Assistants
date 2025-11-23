class Solution:
    def taskSchedulerII(self, tasks: list[int], space: int) -> int:
        current_time = 0
        last_execution_time = {}

        for task in tasks:
            if task in last_execution_time:
                last_time = last_execution_time[task]
                next_available_time_for_this_task = last_time + space + 1
                current_time = max(current_time + 1, next_available_time_for_this_task)
            else:
                current_time += 1

            last_execution_time[task] = current_time

        return current_time