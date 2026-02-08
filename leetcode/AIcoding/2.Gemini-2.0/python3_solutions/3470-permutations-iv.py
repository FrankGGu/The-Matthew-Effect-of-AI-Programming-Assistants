from collections import Counter

class Solution:
    def permutation(self, nums: list[int]) -> list[list[int]]:
        result = []
        counts = Counter(nums)

        def backtrack(permutation):
            if len(permutation) == len(nums):
                result.append(permutation.copy())
                return

            for num in counts:
                if counts[num] > 0:
                    permutation.append(num)
                    counts[num] -= 1
                    backtrack(permutation)
                    counts[num] += 1
                    permutation.pop()

        backtrack([])
        return result