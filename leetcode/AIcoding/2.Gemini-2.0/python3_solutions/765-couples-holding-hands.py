class Solution:
    def minSwapsCouples(self, row: list[int]) -> int:
        n = len(row) // 2
        pos = [0] * (2 * n)
        for i, v in enumerate(row):
            pos[v] = i

        ans = 0
        for i in range(0, 2 * n, 2):
            a = row[i]
            b = a ^ 1
            if row[i + 1] != b:
                ans += 1
                j = pos[b]
                row[i + 1], row[j] = row[j], row[i + 1]
                pos[row[j]] = j
                pos[row[i + 1]] = i + 1
        return ans