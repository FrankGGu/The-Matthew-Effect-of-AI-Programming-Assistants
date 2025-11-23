class Solution:
    def divideArray(self, nums: list[int], k: int) -> list[list[int]]:
        n = len(nums)
        if n % 3 != 0:
            return []

        nums.sort()
        result = []

        for i in range(0, n, 3):
            if nums[i+2] - nums[i] > k:
                return []
            result.append([nums[i], nums[i+1], nums[i+2]])

        return result