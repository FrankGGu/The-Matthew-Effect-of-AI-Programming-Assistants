class Solution:
    def minimumReplacement(self, nums: List[int]) -> int:
        n = len(nums)
        last = nums[n - 1]
        ans = 0
        for i in range(n - 2, -1, -1):
            if nums[i] > last:
                k = (nums[i] + last - 1) // last
                ans += k - 1
                last = nums[i] // k
            else:
                last = nums[i]
        return ans