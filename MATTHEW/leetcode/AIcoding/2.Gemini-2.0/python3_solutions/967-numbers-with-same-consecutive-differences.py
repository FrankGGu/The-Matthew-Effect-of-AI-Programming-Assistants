class Solution:
    def numsSameConsecDiff(self, n: int, k: int) -> list[int]:
        def dfs(num, n, k):
            if n == 0:
                return [num]

            last_digit = num % 10
            result = []

            if last_digit + k <= 9:
                result.extend(dfs(num * 10 + last_digit + k, n - 1, k))

            if k != 0 and last_digit - k >= 0:
                result.extend(dfs(num * 10 + last_digit - k, n - 1, k))

            return result

        result = []
        for i in range(1, 10):
            result.extend(dfs(i, n - 1, k))

        return list(set(result))