class Solution:
    def numberOfWeeks(self, tasks: list[int]) -> int:
        total_sum = sum(tasks)
        max_task = max(tasks)

        if max_task > (total_sum - max_task) + 1:
            return 2 * (total_sum - max_task) + 1
        else:
            return total_sum