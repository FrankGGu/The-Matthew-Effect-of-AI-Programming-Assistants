class Solution:
    def findStableMountainIndices(self, nums: List[int]) -> List[int]:
        n = len(nums)
        if n < 3:
            return []

        left = [0] * n
        for i in range(1, n):
            if nums[i] > nums[i-1]:
                left[i] = left[i-1] + 1
            else:
                left[i] = 0

        right = [0] * n
        for i in range(n-2, -1, -1):
            if nums[i] > nums[i+1]:
                right[i] = right[i+1] + 1
            else:
                right[i] = 0

        res = []
        for i in range(n):
            if left[i] >= 1 and right[i] >= 1:
                res.append(i)

        return res