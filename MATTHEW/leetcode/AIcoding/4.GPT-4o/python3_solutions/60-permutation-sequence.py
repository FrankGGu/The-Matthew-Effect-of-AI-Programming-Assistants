class Solution:
    def getPermutation(self, n: int, k: int) -> str:
        factorial = [1] * (n + 1)
        for i in range(1, n + 1):
            factorial[i] = factorial[i - 1] * i

        nums = list(range(1, n + 1))
        k -= 1
        permutation = []

        for i in range(n):
            idx = k // factorial[n - 1 - i]
            permutation.append(str(nums[idx]))
            nums.pop(idx)
            k %= factorial[n - 1 - i]

        return ''.join(permutation)