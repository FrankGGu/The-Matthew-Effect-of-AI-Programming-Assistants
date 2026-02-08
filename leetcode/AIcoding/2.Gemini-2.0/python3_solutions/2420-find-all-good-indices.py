class Solution:
    def goodIndices(self, nums: list[int], k: int) -> list[int]:
        n = len(nums)
        if n < 2 * k + 1:
            return []

        inc = [1] * n
        dec = [1] * n

        for i in range(1, n):
            if nums[i] <= nums[i - 1]:
                dec[i] = dec[i - 1] + 1
            if nums[n - 1 - i] <= nums[n - i]:
                inc[n - 1 - i] = inc[n - i] + 1

        res = []
        for i in range(k, n - k):
            if dec[i - 1] >= k and inc[i + 1] >= k:
                res.append(i)

        return res