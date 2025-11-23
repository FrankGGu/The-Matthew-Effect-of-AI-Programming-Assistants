class Solution:
    def permuteUnique(self, nums: list[int]) -> list[list[int]]:
        result = []
        nums.sort()
        n = len(nums)
        used = [False] * n

        def backtrack(current_permutation):
            if len(current_permutation) == n:
                result.append(list(current_permutation))
                return

            for i in range(n):
                if used[i]:
                    continue

                # Skip duplicates:
                # If the current number is the same as the previous number,
                # AND the previous number was NOT used (meaning it was either skipped
                # in the current loop iteration or backtracked from a previous path),
                # then skipping the current number avoids duplicate permutations.
                if i > 0 and nums[i] == nums[i-1] and not used[i-1]:
                    continue

                used[i] = True
                current_permutation.append(nums[i])
                backtrack(current_permutation)
                current_permutation.pop()
                used[i] = False

        backtrack([])
        return result