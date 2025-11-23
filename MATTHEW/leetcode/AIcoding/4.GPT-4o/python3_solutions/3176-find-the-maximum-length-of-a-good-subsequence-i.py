class Solution:
    def maximumGood(self, statements: List[List[int]]) -> int:
        n = len(statements)
        max_good = 0

        for mask in range(1 << n):
            good = True
            for i in range(n):
                if (mask & (1 << i)) != 0:
                    for j in range(n):
                        if statements[i][j] == 1 and (mask & (1 << j)) == 0:
                            good = False
                            break
                        if statements[i][j] == 0 and (mask & (1 << j)) != 0:
                            good = False
                            break
                if not good:
                    break

            if good:
                max_good = max(max_good, bin(mask).count('1'))

        return max_good