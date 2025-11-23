class Solution:
    def minDeletionSize(self, strs: List[str]) -> int:
        m, n = len(strs), len(strs[0])
        res = 0
        keep = [True] * m
        for j in range(n):
            temp = True
            for i in range(1, m):
                if keep[i] and strs[i][j] < strs[i - 1][j]:
                    res += 1
                    temp = False
                    break
            if temp:
                new_keep = keep[:]
                for i in range(1, m):
                    if keep[i] and strs[i][j] > strs[i - 1][j]:
                        new_keep[i] = False
                keep = new_keep
        return res