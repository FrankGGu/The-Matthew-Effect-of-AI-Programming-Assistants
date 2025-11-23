class Solution:
    def minSwapsCouples(self, row: List[int]) -> int:
        n = len(row) // 2
        pos = {row[i]: i for i in range(len(row))}
        swaps = 0

        for i in range(0, len(row), 2):
            a = row[i]
            b = a ^ 1

            if row[i + 1] != b:
                swaps += 1
                pos[row[i + 1]] = pos[b]
                row[pos[b]], row[i + 1] = row[i + 1], row[pos[b]]

        return swaps