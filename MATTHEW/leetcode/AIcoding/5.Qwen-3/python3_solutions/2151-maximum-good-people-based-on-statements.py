class Solution:
    def maximumGood(self, statements: List[str]) -> int:
        n = len(statements)
        max_good = 0

        for mask in range(1 << n):
            valid = True
            for i in range(n):
                if (mask >> i) & 1:
                    for j in range(n):
                        if (mask >> j) & 1:
                            if statements[i][j] == '0':
                                valid = False
                                break
                    if not valid:
                        break
            if valid:
                max_good = max(max_good, bin(mask).count('1'))

        return max_good