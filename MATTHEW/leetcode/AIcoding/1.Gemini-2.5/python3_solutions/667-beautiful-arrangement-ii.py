class Solution:
    def constructArray(self, n: int, k: int) -> list[int]:
        ans = []

        left = 1
        right = k + 1

        while left <= right:
            ans.append(left)
            left += 1
            if left <= right:
                ans.append(right)
                right -= 1

        for i in range(k + 2, n + 1):
            ans.append(i)

        return ans