import functools

class Solution:
    def minSkips(self, dist: list[int], speed: int, hoursBefore: int) -> int:
        n = len(dist)

        @functools.lru_cache(None)
        def dp(i, skips):
            if i == n:
                return 0

            # Skip
            skip_time = dp(i + 1, skips - 1) if skips > 0 else float('inf')

            # Don't skip
            curr_time = (dp(i + 1, skips) + dist[i] + speed - 1) // speed * speed

            return min(skip_time, (curr_time if curr_time != float('inf') else float('inf')))

        for skips in range(n):
            total_time = dp(0, skips)
            if total_time <= hoursBefore * speed:
                return skips
        return -1