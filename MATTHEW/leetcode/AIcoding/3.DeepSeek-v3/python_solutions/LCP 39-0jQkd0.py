class Solution:
    def minSwaps(self, grid: List[List[int]]) -> int:
        n = len(grid)
        trailing_zeros = []

        for row in grid:
            zeros = 0
            for num in reversed(row):
                if num == 0:
                    zeros += 1
                else:
                    break
            trailing_zeros.append(zeros)

        res = 0
        for i in range(n):
            required = n - 1 - i
            j = i
            while j < n and trailing_zeros[j] < required:
                j += 1
            if j == n:
                return -1
            res += j - i
            trailing_zeros.insert(i, trailing_zeros.pop(j))

        return res