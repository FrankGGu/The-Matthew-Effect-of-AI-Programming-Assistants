class Solution:
    def minSessions(self, tasks: List[int], sessionTime: int) -> int:
        from functools import lru_cache

        n = len(tasks)
        tasks.sort(reverse=True)

        @lru_cache(None)
        def dp(mask, time):
            if mask == (1 << n) - 1:
                return 0
            res = float('inf')
            for i in range(n):
                if not (mask & (1 << i)):
                    new_mask = mask | (1 << i)
                    if time + tasks[i] <= sessionTime:
                        res = min(res, dp(new_mask, time + tasks[i]))
                    else:
                        res = min(res, 1 + dp(new_mask, tasks[i]))
            return res

        return dp(0, 0)