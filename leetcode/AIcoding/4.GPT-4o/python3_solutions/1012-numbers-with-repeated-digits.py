class Solution:
    def numDupDigitsAtMostN(self, N: int) -> int:
        def count_unique_digits(n):
            str_n = str(n)
            length = len(str_n)
            count = 0
            used = [0] * 10

            for i in range(1, length):
                count += 9 * perm(9, i - 1)

            for i in range(length):
                for j in range(1 if i == 0 else 0, int(str_n[i])):
                    if not used[j]:
                        count += perm(9 - i, length - i - 1)
                if used[int(str_n[i])]:
                    break
                used[int(str_n[i])] = 1
            else:
                count += 1

            return count

        def perm(m, n):
            if n == 0:
                return 1
            res = 1
            for i in range(m, m - n, -1):
                res *= i
            return res

        return N - count_unique_digits(N)