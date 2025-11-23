class Solution:
    def countTriplets(self, nums: List[int]) -> int:
        count = 0
        n = len(nums)
        for i in range(n):
            for j in range(n):
                for k in range(n):
                    if nums[i] & nums[j] & nums[k] == 0:
                        count += 1
        return count