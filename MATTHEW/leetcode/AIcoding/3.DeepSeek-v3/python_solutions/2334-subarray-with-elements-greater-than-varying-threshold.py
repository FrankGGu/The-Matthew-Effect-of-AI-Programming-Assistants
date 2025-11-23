class Solution:
    def validSubarraySize(self, nums: List[int], threshold: int) -> int:
        nums = [0] + nums + [0]
        stack = []
        for i, num in enumerate(nums):
            while stack and nums[stack[-1]] > num:
                h = nums[stack.pop()]
                left = stack[-1]
                k = i - left - 1
                if h > threshold / k:
                    return k
            stack.append(i)
        return -1