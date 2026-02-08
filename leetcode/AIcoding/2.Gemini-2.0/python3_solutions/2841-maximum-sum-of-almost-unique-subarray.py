class Solution:
    def maxSum(self, nums: List[int], m: int, k: int) -> int:
        ans = 0
        curr_sum = 0
        count = {}
        l = 0
        for r in range(len(nums)):
            count[nums[r]] = count.get(nums[r], 0) + 1
            curr_sum += nums[r]
            while r - l + 1 > k:
                count[nums[l]] -= 1
                curr_sum -= nums[l]
                if count[nums[l]] == 0:
                    del count[nums[l]]
                l += 1
            if r - l + 1 == k and len(count) >= m:
                ans = max(ans, curr_sum)
        return ans