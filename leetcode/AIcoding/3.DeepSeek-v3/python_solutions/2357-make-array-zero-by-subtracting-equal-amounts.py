class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        unique_non_zero = set()
        for num in nums:
            if num != 0:
                unique_non_zero.add(num)
        return len(unique_non_zero)