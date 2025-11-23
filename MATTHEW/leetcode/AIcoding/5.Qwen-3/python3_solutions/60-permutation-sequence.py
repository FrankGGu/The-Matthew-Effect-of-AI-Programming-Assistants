class Solution:
    def getPermutation(self, n: int, k: int) -> str:
        import math
        nums = list(range(1, n + 1))
        k -= 1
        result = []
        while n > 0:
            factorial = math.factorial(n - 1)
            index = k // factorial
            result.append(str(nums[index]))
            nums.pop(index)
            k %= factorial
            n -= 1
        return ''.join(result)