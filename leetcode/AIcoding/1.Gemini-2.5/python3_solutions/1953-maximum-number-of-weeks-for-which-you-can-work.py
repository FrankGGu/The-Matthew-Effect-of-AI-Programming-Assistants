class Solution:
    def numberOfWeeks(self, milestones: list[int]) -> int:
        total_tasks = sum(milestones)
        max_tasks = max(milestones)

        if max_tasks <= (total_tasks - max_tasks) + 1:
            return total_tasks
        else:
            return 2 * (total_tasks - max_tasks) + 1