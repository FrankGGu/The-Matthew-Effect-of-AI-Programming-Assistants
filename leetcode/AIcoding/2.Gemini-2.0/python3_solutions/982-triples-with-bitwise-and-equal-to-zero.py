class Solution:
    def countTriplets(self, nums: List[int]) -> int:
        count = 0
        for i in range(len(nums)):
            for j in range(len(nums)):
                for k in range(len(nums)):
                    if (nums[i] & nums[j] & nums[k]) == 0:
                        count += 1
        return count