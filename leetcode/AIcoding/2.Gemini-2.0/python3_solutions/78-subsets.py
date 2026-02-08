class Solution:
    def subsets(self, nums: List[int]) -> List[List[int]]:
        result = []
        def backtrack(index, current_subset):
            result.append(current_subset.copy())

            for i in range(index, len(nums)):
                current_subset.append(nums[i])
                backtrack(i + 1, current_subset)
                current_subset.pop()

        backtrack(0, [])
        return result