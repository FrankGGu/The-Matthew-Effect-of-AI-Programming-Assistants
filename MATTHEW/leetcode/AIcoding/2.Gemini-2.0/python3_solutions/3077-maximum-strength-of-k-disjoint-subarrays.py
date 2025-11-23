class Solution:
    def solve(self, nums, k, index, count, product, dp):
        if count == k:
            return product
        if index == len(nums):
            return -float('inf')
        if (index, count, product) in dp:
            return dp[(index, count, product)]

        include = self.solve(nums, k, index + 1, count + 1, product * nums[index], dp)
        exclude = self.solve(nums, k, index + 1, count, product, dp)

        dp[(index, count, product)] = max(include, exclude)
        return dp[(index, count, product)]

    def maxStrength(self, nums: List[int], k: int) -> int:
        nums.sort()
        dp = {}
        return self.solve(nums, k, 0, 0, 1, dp)