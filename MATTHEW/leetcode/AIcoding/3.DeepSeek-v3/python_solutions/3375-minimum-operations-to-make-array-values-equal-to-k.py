class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        operations = 0
        for num in nums:
            if num < k:
                operations += k - num
            elif num > k:
                operations += num - k
        return operations