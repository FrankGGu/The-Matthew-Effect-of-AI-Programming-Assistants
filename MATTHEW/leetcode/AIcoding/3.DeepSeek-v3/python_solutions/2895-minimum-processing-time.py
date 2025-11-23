class Solution:
    def minProcessingTime(self, processorTime: List[int], tasks: List[int]) -> int:
        processorTime.sort()
        tasks.sort(reverse=True)
        max_time = 0
        for i in range(len(processorTime)):
            current_max = processorTime[i] + tasks[4 * i]
            if current_max > max_time:
                max_time = current_max
        return max_time