class Solution:
    def constructArray(self, n: int, k: int) -> list[int]:
        result = []
        left = 1
        right = k + 1

        while left <= right:
            result.append(left)
            left += 1
            if left <= right:
                result.append(right)
                right -= 1

        for i in range(k + 2, n + 1):
            result.append(i)

        return result