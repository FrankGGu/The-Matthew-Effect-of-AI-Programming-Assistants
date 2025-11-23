class Solution:
    def subsetXORSum(self, nums: List[int]) -> int:
        def backtrack(index, current_xor):
            if index == len(nums):
                return current_xor
            return backtrack(index + 1, current_xor ^ nums[index]) + backtrack(index + 1, current_xor)

        return backtrack(0, 0)