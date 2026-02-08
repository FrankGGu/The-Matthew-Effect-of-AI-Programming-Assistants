class Solution:
    def numSubmatrixSumTarget(self, matrix: List[List[int]], target: int) -> int:
        from collections import defaultdict

        if not matrix or not matrix[0]:
            return 0

        rows, cols = len(matrix), len(matrix[0])
        count = 0

        for left in range(cols):
            row_sum = [0] * rows
            for right in range(left, cols):
                for r in range(rows):
                    row_sum[r] += matrix[r][right]

                count += self.subarraySum(row_sum, target)

        return count

    def subarraySum(self, nums: List[int], target: int) -> int:
        count = 0
        prefix_sum = 0
        prefix_count = defaultdict(int)
        prefix_count[0] = 1

        for num in nums:
            prefix_sum += num
            count += prefix_count[prefix_sum - target]
            prefix_count[prefix_sum] += 1

        return count