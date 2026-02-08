import heapq

class Solution:
    def maxSubsequence(self, nums: list[int], k: int) -> list[int]:
        indices = sorted(range(len(nums)), key=lambda i: nums[i], reverse=True)[:k]
        indices.sort()
        return [nums[i] for i in indices]

    def minSubsequence(self, nums: list[int], k: int) -> list[int]:
        indices = sorted(range(len(nums)), key=lambda i: nums[i])[:k]
        indices.sort()
        return [nums[i] for i in indices]

    def maxSubsequenceSum(self, nums: list[int], k: int) -> int:
        return sum(sorted(nums, reverse=True)[:k])

    def minSubsequenceSum(self, nums: list[int], k: int) -> int:
        return sum(sorted(nums)[:k])