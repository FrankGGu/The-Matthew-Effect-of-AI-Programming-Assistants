from collections import defaultdict

class Solution:
    def findDiagonalOrder(self, nums: list[list[int]]) -> list[int]:
        diagonals = defaultdict(list)

        # Group elements by the sum of their row and column indices (r + c)
        # Elements are appended in increasing order of 'r' for a given sum 's'.
        for r in range(len(nums)):
            for c in range(len(nums[r])):
                diagonals[r + c].append(nums[r][c])

        result = []

        # If nums is empty or contains only empty rows, diagonals will be empty.
        # In this case, max_diag_sum would cause an error or the loops wouldn't run.
        # The result should be an empty list, which is handled by default.
        if not diagonals:
            return []

        # Determine the maximum sum of indices to iterate through all diagonals
        max_diag_sum = max(diagonals.keys())

        # Iterate through diagonal sums in increasing order
        for s in range(max_diag_sum + 1):
            if s in diagonals:
                # For each diagonal, the elements were collected from top-right to bottom-left
                # (due to row-major iteration).
                # To achieve the problem's required bottom-left to top-right traversal order,
                # each diagonal list needs to be reversed.
                result.extend(diagonals[s][::-1])

        return result