class Solution:
    def findGoodIndices(self, nums, key):
        n = len(nums)
        left = [0] * n
        right = [0] * n

        for i in range(1, n):
            if nums[i] == nums[i - 1]:
                left[i] = left[i - 1] + 1
            else:
                left[i] = 0

        for i in range(n - 2, -1, -1):
            if nums[i] == nums[i + 1]:
                right[i] = right[i + 1] + 1
            else:
                right[i] = 0

        result = []
        for i in range(n):
            if left[i] >= key or right[i] >= key:
                result.append(i)
        return result