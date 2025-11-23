class Solution:
    def minSwapsCouples(self, row: List[int]) -> int:
        n = len(row)
        pos = {val: idx for idx, val in enumerate(row)}
        swaps = 0

        for i in range(0, n, 2):
            x = row[i]
            if x % 2 == 0:
                y = x + 1
            else:
                y = x - 1
            if row[i+1] != y:
                j = pos[y]
                row[i+1], row[j] = row[j], row[i+1]
                pos[row[j]] = j
                pos[row[i+1]] = i+1
                swaps += 1
        return swaps