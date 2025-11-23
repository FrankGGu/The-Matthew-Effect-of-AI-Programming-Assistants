import functools

class Solution:
    def minCost(self, nums: list[int], k: int) -> int:
        n = len(nums)

        @functools.lru_cache(None)
        def dp(i):
            if i == n:
                return 0

            ans = float('inf')
            for j in range(i, n):
                cost = k
                counts = {}
                redundancy = 0
                for l in range(i, j + 1):
                    if nums[l] in counts:
                        counts[nums[l]] += 1
                    else:
                        counts[nums[l]] = 1

                    if counts[nums[l]] > 1:
                        redundancy += 1

                cost += redundancy
                ans = min(ans, cost + dp(j + 1))

            return ans

        return dp(0)