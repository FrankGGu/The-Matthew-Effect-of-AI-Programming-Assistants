class Solution:
    def findOriginal(self, s: str) -> str:
        n = len(s)
        memo = {}

        def solve(i, j):
            if i == n:
                return "" if j == 0 else None
            if (i, j) in memo:
                return memo[(i, j)]

            res = None
            for length in range(1, min(11, n - i + 1)):
                num_str = s[i:i + length]
                if num_str.isdigit() and 1 <= int(num_str) <= 9:
                    num = int(num_str)
                    if num <= j:
                        temp = solve(i + length, j - num)
                        if temp is not None:
                            if res is None or temp < res:
                                res = temp
                else:
                    if j == 0:
                        temp = solve(i + 1, 1)
                        if temp is not None:
                            if res is None or s[i] + temp < res:
                                res = s[i] + temp
            memo[(i, j)] = res
            return res

        return solve(0, 0)