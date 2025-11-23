class Solution:
    def minimumProcessingTime(self, tasks: List[int]) -> int:
        tasks.sort()
        total_time = 0
        current_time = 0

        for task in tasks:
            current_time += task
            total_time += current_time

        return total_time