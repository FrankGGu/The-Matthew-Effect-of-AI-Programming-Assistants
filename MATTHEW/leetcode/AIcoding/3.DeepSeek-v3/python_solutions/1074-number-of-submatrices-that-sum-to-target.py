class Solution:
    def numSubmatrixSumTarget(self, matrix: List[List[int]], target: int) -> int:
        rows, cols = len(matrix), len(matrix[0])
        prefix = [[0] * (cols + 1) for _ in range(rows + 1)]

        for r in range(rows):
            row_sum = 0
            for c in range(cols):
                row_sum += matrix[r][c]
                prefix[r+1][c+1] = prefix[r][c+1] + row_sum

        res = 0
        for r1 in range(rows):
            for r2 in range(r1, rows):
                count = defaultdict(int)
                count[0] = 1
                current_sum = 0
                for c in range(cols):
                    current_sum += prefix[r2+1][c+1] - prefix[r1][c+1]
                    res += count[current_sum - target]
                    count[current_sum] += 1
        return res