class Solution:
    def beautifulIndices(self, nums: List[int]) -> List[int]:
        n = len(nums)
        result = []

        for i in range(n):
            if (i == 0 or nums[i] > nums[i - 1]) and (i == n - 1 or nums[i] > nums[i + 1]):
                result.append(i)

        return result