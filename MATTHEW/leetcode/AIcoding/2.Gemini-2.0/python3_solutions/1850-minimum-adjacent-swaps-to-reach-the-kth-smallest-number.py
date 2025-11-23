class Solution:
    def getPermutation(self, n: int, k: int) -> str:
        nums = list(range(1, n + 1))
        factorial = [1] * (n + 1)
        for i in range(2, n + 1):
            factorial[i] = factorial[i - 1] * i

        k -= 1
        result = ""
        for i in range(n, 0, -1):
            index = k // factorial[i - 1]
            result += str(nums[index])
            nums.pop(index)
            k %= factorial[i - 1]

        return result

    def getMinSwaps(self, num: str, k: int) -> int:
        original_num = list(num)
        next_permutation = list(num)
        n = len(num)

        for _ in range(k):
            i = n - 2
            while i >= 0 and next_permutation[i] >= next_permutation[i + 1]:
                i -= 1

            if i >= 0:
                j = n - 1
                while next_permutation[j] <= next_permutation[i]:
                    j -= 1

                next_permutation[i], next_permutation[j] = next_permutation[j], next_permutation[i]

            left, right = i + 1, n - 1
            while left < right:
                next_permutation[left], next_permutation[right] = next_permutation[right], next_permutation[left]
                left += 1
                right -= 1

        swaps = 0
        original = list(num)
        target = next_permutation

        for i in range(n):
            if original[i] != target[i]:
                j = i + 1
                while original[j] != target[i]:
                    j += 1
                while j > i:
                    original[j], original[j - 1] = original[j - 1], original[j]
                    swaps += 1
                    j -= 1

        return swaps