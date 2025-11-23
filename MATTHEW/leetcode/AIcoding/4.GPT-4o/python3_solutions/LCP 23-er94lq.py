class Solution:
    def getPermutation(self, n: int, k: int) -> str:
        nums = list(range(1, n + 1))
        k -= 1
        factorial = [1] * n

        for i in range(1, n):
            factorial[i] = factorial[i - 1] * i

        result = []

        for i in range(n):
            idx = k // factorial[n - 1 - i]
            result.append(str(nums[idx]))
            nums.pop(idx)
            k %= factorial[n - 1 - i]

        return ''.join(result)