class Solution:
    def countSubmat(self, matrix: List[List[int]], k: int) -> int:
        if not matrix or not matrix[0]:
            return 0

        m, n = len(matrix), len(matrix[0])
        count = 0

        for i in range(m):
            row_sum = [0] * n
            for j in range(i, m):
                for col in range(n):
                    row_sum[col] += matrix[j][col]

                count += self.countLessThanK(row_sum, k)

        return count

    def countLessThanK(self, row_sum, k):
        total_count = 0
        prefix_sum = [0]
        current_sum = 0

        for num in row_sum:
            current_sum += num
            total_count += self.binary_search(prefix_sum, current_sum - k)
            bisect.insort(prefix_sum, current_sum)

        return total_count

    def binary_search(self, prefix_sum, target):
        left, right = 0, len(prefix_sum)
        while left < right:
            mid = (left + right) // 2
            if prefix_sum[mid] < target:
                left = mid + 1
            else:
                right = mid
        return left