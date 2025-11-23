class Solution:
    def minSessions(self, tasks: List[int], sessionTime: int) -> int:
        from itertools import combinations

        def canFinish(mask, remainingTime):
            if mask == 0:
                return True
            for i in range(len(tasks)):
                if mask & (1 << i):
                    if tasks[i] <= remainingTime:
                        if canFinish(mask ^ (1 << i), remainingTime - tasks[i]):
                            return True
            return False

        n = len(tasks)
        total_masks = 1 << n
        dp = [float('inf')] * total_masks
        dp[0] = 0

        for mask in range(total_masks):
            for remainingTime in range(sessionTime + 1):
                if canFinish(mask, remainingTime):
                    dp[mask] = min(dp[mask], dp[mask] + 1)

        return dp[total_masks - 1]