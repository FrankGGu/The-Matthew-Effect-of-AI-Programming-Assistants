class Solution:
    def arithmeticTriplets(self, nums: List[int], target: int) -> int:
        count = 0
        n = len(nums)
        for i in range(n):
            for j in range(i + 1, n):
                if nums[j] - nums[i] > target:
                    break
                for k in range(j + 1, n):
                    if nums[k] - nums[j] == nums[j] - nums[i]:
                        count += 1
        return count