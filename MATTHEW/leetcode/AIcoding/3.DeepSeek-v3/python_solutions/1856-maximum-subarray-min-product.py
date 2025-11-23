class Solution:
    def maxSumMinProduct(self, nums: List[int]) -> int:
        prefix = [0]
        for num in nums:
            prefix.append(prefix[-1] + num)

        stack = []
        res = 0
        nums.append(0)

        for i, num in enumerate(nums):
            while stack and nums[stack[-1]] > num:
                min_val = nums[stack.pop()]
                left = stack[-1] if stack else -1
                total = prefix[i] - prefix[left + 1]
                res = max(res, min_val * total)
            stack.append(i)

        return res % (10**9 + 7)