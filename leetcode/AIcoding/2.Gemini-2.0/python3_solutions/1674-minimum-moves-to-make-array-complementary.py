class Solution:
    def minMoves(self, nums: list[int], limit: int) -> int:
        n = len(nums)
        delta = [0] * (2 * limit + 2)

        for i in range(n // 2):
            a, b = nums[i], nums[n - 1 - i]
            delta[2] -= 2
            delta[min(a, b) + 1] += 1
            delta[a + b] += 1
            delta[a + b + 1] -= 1
            delta[max(a, b) + limit + 1] -= 1
            delta[2 * limit + 1] += 2

        ans = n
        curr = 0
        for i in range(2, 2 * limit + 1):
            curr += delta[i]
            ans = min(ans, curr)

        return ans