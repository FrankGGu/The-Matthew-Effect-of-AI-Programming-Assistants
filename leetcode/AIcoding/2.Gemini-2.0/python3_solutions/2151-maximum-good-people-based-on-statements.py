class Solution:
    def maximumGood(self, statements: list[list[int]]) -> int:
        n = len(statements)
        ans = 0
        for mask in range(2 ** n):
            good_count = 0
            consistent = True
            for i in range(n):
                if (mask >> i) & 1:
                    good_count += 1
                    for j in range(n):
                        if statements[i][j] != 2:
                            if ((mask >> j) & 1) != statements[i][j]:
                                consistent = False
                                break
                if not consistent:
                    break
            if consistent:
                ans = max(ans, good_count)
        return ans