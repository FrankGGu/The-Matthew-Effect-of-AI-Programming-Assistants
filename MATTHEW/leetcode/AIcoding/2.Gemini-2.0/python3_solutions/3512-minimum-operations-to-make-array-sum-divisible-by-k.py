class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        if k == 1:
            return 0
        s = sum(nums) % k
        if s == 0:
            return 0
        n = len(nums)
        ans = n
        prefix_sum = 0
        seen = {0: -1}
        for i in range(n):
            prefix_sum = (prefix_sum + nums[i]) % k
            if (prefix_sum - s) % k in seen:
                ans = min(ans, i - seen[(prefix_sum - s) % k])
            if prefix_sum not in seen:
                seen[prefix_sum] = i
        return ans if ans != n else -1