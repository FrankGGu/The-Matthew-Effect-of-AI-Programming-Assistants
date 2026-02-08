class Solution:
    def findPoisonedDuration(self, timeSeries: list[int], duration: int) -> int:
        if not timeSeries:
            return 0

        total_poisoned_duration = 0
        n = len(timeSeries)

        for i in range(n - 1):
            total_poisoned_duration += min(duration, timeSeries[i+1] - timeSeries[i])

        total_poisoned_duration += duration

        return total_poisoned_duration