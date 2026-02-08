class Solution:
    def findSubsequences(self, nums: list[int]) -> list[list[int]]:
        result = set()

        def backtrack(start_index, current_path):
            if len(current_path) >= 2:
                result.add(tuple(current_path))

            for i in range(start_index, len(nums)):
                if not current_path or nums[i] >= current_path[-1]:
                    current_path.append(nums[i])
                    backtrack(i + 1, current_path)
                    current_path.pop()

        backtrack(0, [])
        return [list(s) for s in result]