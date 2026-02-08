class Solution:
    def minProcessingTime(self, processorTime: list[int], tasks: list[int]) -> int:
        processorTime.sort()
        tasks.sort(reverse=True)
        max_time = 0
        for i in range(len(processorTime)):
            for j in range(4):
                max_time = max(max_time, processorTime[i] + tasks[i * 4 + j])
        return max_time