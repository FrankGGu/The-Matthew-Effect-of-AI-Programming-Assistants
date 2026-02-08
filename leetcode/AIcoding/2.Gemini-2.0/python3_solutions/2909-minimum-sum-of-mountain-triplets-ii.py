class Solution:
    def minimumSum(self, nums: List[int]) -> int:
        n = len(nums)
        prefix_min = [float('inf')] * n
        suffix_min = [float('inf')] * n

        prefix_min[0] = nums[0]
        for i in range(1, n):
            prefix_min[i] = min(prefix_min[i - 1], nums[i])

        suffix_min[n - 1] = nums[n - 1]
        for i in range(n - 2, -1, -1):
            suffix_min[i] = min(suffix_min[i + 1], nums[i])

        ans = float('inf')
        for j in range(1, n - 1):
            i_val = prefix_min[j - 1]
            k_val = suffix_min[j + 1]
            if i_val < nums[j] and k_val < nums[j]:
                ans = min(ans, i_val + nums[j] + k_val)

        if ans == float('inf'):
            return -1
        return ans