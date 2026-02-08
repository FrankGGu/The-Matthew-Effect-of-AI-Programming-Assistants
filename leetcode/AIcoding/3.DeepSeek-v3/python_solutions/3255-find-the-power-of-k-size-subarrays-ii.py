class Solution:
    def sumOfPowers(self, nums: List[int], k: int) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        res = 0

        for i in range(n - k + 1):
            subarray = nums[i:i+k]
            min_diff = float('inf')
            for j in range(len(subarray)):
                for l in range(j + 1, len(subarray)):
                    diff = abs(subarray[j] - subarray[l])
                    if diff < min_diff:
                        min_diff = diff
            if min_diff != float('inf'):
                res = (res + min_diff) % MOD

        return res