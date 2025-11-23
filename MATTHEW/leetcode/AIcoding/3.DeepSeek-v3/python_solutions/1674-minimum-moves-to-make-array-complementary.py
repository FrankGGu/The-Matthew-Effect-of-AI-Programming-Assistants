class Solution:
    def minMoves(self, nums: List[int], limit: int) -> int:
        delta = [0] * (2 * limit + 2)
        n = len(nums)
        for i in range(n // 2):
            a, b = nums[i], nums[n - 1 - i]
            left = 2
            right = 2 * limit
            delta[left] += 2
            delta[right + 1] -= 2

            left = 1 + min(a, b)
            right = limit + max(a, b)
            delta[left] += -1
            delta[right + 1] -= -1

            left = a + b
            right = a + b
            delta[left] += -1
            delta[right + 1] -= -1

        res = float('inf')
        current = 0
        for target in range(2, 2 * limit + 1):
            current += delta[target]
            if current < res:
                res = current
        return res