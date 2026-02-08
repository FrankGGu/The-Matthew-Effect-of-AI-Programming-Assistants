class Solution:
    def getPermutation(self, n: int, k: int) -> str:
        numbers = list(range(1, n+1))
        factorial = [1] * n
        for i in range(1, n):
            factorial[i] = factorial[i-1] * i

        k -= 1
        res = []
        for i in range(n, 0, -1):
            index = k // factorial[i-1]
            k %= factorial[i-1]
            res.append(str(numbers.pop(index)))

        return ''.join(res)