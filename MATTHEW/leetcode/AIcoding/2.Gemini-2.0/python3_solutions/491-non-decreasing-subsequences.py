class Solution:
    def findSubsequences(self, nums: List[int]) -> List[List[int]]:
        result = set()
        def backtrack(index, subsequence):
            if len(subsequence) >= 2:
                result.add(tuple(subsequence))

            if index == len(nums):
                return

            if not subsequence or nums[index] >= subsequence[-1]:
                backtrack(index + 1, subsequence + [nums[index]])
            backtrack(index + 1, subsequence)

        backtrack(0, [])
        return list(map(list, result))