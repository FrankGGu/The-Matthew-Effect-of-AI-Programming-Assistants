class Solution:
    def specialArray(self, nums: List[int]) -> int:
        for x in range(len(nums) + 1):
            if sum(1 for num in nums if num >= x) == x:
                return x
        return -1