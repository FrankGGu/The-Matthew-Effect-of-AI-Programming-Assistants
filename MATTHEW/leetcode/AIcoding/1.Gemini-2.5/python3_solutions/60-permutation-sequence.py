import math

class Solution:
    def getPermutation(self, n: int, k: int) -> str:
        factorials = [1] * (n + 1)
        for i in range(1, n + 1):
            factorials[i] = factorials[i-1] * i

        numbers = [str(i) for i in range(1, n + 1)]
        result = []

        # Adjust k to be 0-indexed
        k -= 1

        for i in range(n - 1, -1, -1):
            # i represents the remaining count of numbers - 1
            # factorials[i] gives (remaining_count - 1)!

            idx = k // factorials[i]
            result.append(numbers[idx])
            numbers.pop(idx)
            k %= factorials[i]

        return "".join(result)