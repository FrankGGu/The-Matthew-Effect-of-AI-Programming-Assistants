class Solution:
    def findMissingAndRepeatedValues(self, grid: List[List[int]]) -> List[int]:
        n = len(grid)
        total = n * n
        seen = set()
        repeated = -1
        actual_sum = 0

        for row in grid:
            for num in row:
                actual_sum += num
                if num in seen:
                    repeated = num
                seen.add(num)

        expected_sum = total * (total + 1) // 2
        missing = expected_sum - (actual_sum - repeated)

        return [repeated, missing]