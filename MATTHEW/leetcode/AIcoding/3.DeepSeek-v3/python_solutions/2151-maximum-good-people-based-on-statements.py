class Solution:
    def maximumGood(self, statements: List[List[int]]) -> int:
        n = len(statements)
        max_good = 0

        for mask in range(1 << n):
            valid = True
            good_count = bin(mask).count('1')

            if good_count <= max_good:
                continue

            for i in range(n):
                if not (mask & (1 << i)):
                    continue
                for j in range(n):
                    if statements[i][j] == 2:
                        continue
                    expected = (mask >> j) & 1
                    if statements[i][j] != expected:
                        valid = False
                        break
                if not valid:
                    break

            if valid:
                max_good = good_count

        return max_good