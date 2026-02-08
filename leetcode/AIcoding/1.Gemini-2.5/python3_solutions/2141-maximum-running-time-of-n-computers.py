class Solution:
    def maxRunTime(self, n: int, batteries: list[int]) -> int:

        def check(time: int) -> bool:
            total_effective_power = 0
            for b in batteries:
                total_effective_power += min(b, time)

            return total_effective_power >= n * time

        low = 0
        high = sum(batteries) // n

        ans = 0

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans