class Solution:
    def canSplit(self, nums: List[int]) -> bool:
        n = len(nums)
        for i in range(1, n):
            left = nums[:i]
            right = nums[i:]
            if all(left[j] < left[j+1] for j in range(len(left)-1)) and all(right[j] < right[j+1] for j in range(len(right)-1)):
                return True
        return False