class Solution:
    def maximumGood(self, statements: List[List[int]]) -> int:
        n = len(statements)
        max_good_sum = 0

        for mask in range(1 << n):
            good = True
            sum_good = 0

            for i in range(n):
                if mask & (1 << i):
                    sum_good += i + 1
                    for j in range(n):
                        if statements[i][j] == 1 and not (mask & (1 << j)):
                            good = False
                        elif statements[i][j] == 0 and (mask & (1 << j)):
                            good = False

            if good:
                max_good_sum = max(max_good_sum, sum_good)

        return max_good_sum