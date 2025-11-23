class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = {}

        def solve(idx, subarrays):
            if idx == n:
                return 0 if subarrays <= k else float('inf')

            if (idx, subarrays) in dp:
                return dp[(idx, subarrays)]

            ans = float('inf')
            for i in range(idx, n):
                count = 0
                subarray = nums[idx:i+1]
                mode = {}
                max_freq = 0
                for num in subarray:
                    mode[num] = mode.get(num, 0) + 1
                    max_freq = max(max_freq, mode[num])

                count = len(subarray) - max_freq
                ans = min(ans, count + solve(i + 1, subarrays + 1))

            dp[(idx, subarrays)] = ans
            return ans

        return solve(0, 0)