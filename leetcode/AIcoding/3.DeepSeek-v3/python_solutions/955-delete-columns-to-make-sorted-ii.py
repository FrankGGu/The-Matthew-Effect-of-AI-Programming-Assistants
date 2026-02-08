class Solution:
    def minDeletionSize(self, strs: List[str]) -> int:
        n = len(strs)
        m = len(strs[0]) if n else 0
        res = 0
        sorted_cols = [False] * (n - 1)

        for j in range(m):
            temp = sorted_cols.copy()
            to_delete = False
            for i in range(n - 1):
                if not temp[i] and strs[i][j] > strs[i+1][j]:
                    to_delete = True
                    break
            if to_delete:
                res += 1
            else:
                for i in range(n - 1):
                    if strs[i][j] < strs[i+1][j]:
                        temp[i] = True
                sorted_cols = temp
        return res