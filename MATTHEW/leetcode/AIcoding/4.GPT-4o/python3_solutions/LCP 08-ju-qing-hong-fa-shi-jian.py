class Solution:
    def getTriggerTime(self, timeSeries: List[int], duration: int) -> int:
        total_time = 0
        for i in range(len(timeSeries)):
            if i == 0:
                total_time += duration
            else:
                total_time += min(duration, timeSeries[i] - timeSeries[i - 1])
        total_time += duration
        return total_time