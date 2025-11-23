class Solution:
    def numSubarrayBoundedBy(self, left: int, right: int, nums: List[int]) -> int:
        count = 0
        last = -1
        prev = -1
        for i in range(len(nums)):
            if nums[i] >= left and nums[i] <= right:
                prev = i
            elif nums[i] < left:
                pass
            else:
                last = i
                prev = -1
            if prev != -1:
                count += prev - last
        return count