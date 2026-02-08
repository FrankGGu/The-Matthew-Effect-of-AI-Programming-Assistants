class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:
        result = []
        nums.sort()
        def backtrack(permutation, remaining):
            if not remaining:
                result.append(permutation.copy())
                return

            for i in range(len(remaining)):
                if i > 0 and remaining[i] == remaining[i-1]:
                    continue

                permutation.append(remaining[i])
                backtrack(permutation, remaining[:i] + remaining[i+1:])
                permutation.pop()

        backtrack([], nums)
        return result