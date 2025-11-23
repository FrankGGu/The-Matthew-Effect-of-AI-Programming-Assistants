class Solution:
    def maximumGood(self, statements: List[List[int]]) -> int:
        n = len(statements)
        max_good = 0

        for mask in range(1 << n):
            good_count = 0
            valid = True

            for i in range(n):
                if (mask >> i) & 1:
                    good_count += 1
                    for j in range(n):
                        if statements[i][j] == 1 and not ((mask >> j) & 1):
                            valid = False
                            break
                        if statements[i][j] == 0 and (mask >> j) & 1:
                            valid = False
                            break
                if not valid:
                    break

            if valid:
                max_good = max(max_good, good_count)

        return max_good