class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        if not nums:
            return [[]]

        result = []

        def backtrack(curr_permutation, remaining_nums):
            if not remaining_nums:
                result.append(curr_permutation.copy())
                return

            for i in range(len(remaining_nums)):
                curr_permutation.append(remaining_nums[i])
                backtrack(curr_permutation, remaining_nums[:i] + remaining_nums[i+1:])
                curr_permutation.pop()

        backtrack([], nums)
        return result