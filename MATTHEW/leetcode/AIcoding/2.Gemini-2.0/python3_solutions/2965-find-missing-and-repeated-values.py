class Solution:
    def findMissingAndRepeatedValues(self, grid: list[list[int]]) -> list[int]:
        n = len(grid)
        nums = [num for row in grid for num in row]

        count = {}
        for num in nums:
            count[num] = count.get(num, 0) + 1

        repeated = 0
        for num, freq in count.items():
            if freq > 1:
                repeated = num
                break

        expected_sum = (n * n * (n * n + 1)) // 2
        actual_sum = sum(nums)

        missing = repeated + (expected_sum - actual_sum)

        return [repeated, missing]