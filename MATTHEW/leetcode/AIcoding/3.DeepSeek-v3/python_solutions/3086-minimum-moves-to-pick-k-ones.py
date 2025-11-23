class Solution:
    def minMoves(self, nums: List[int], k: int) -> int:
        ones = [i for i, num in enumerate(nums) if num == 1]
        n = len(ones)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + ones[i]

        res = float('inf')
        radius = (k - 1) // 2
        for i in range(n - k + 1):
            j = i + k - 1
            mid = (i + j) // 2
            left = ones[mid] * (mid - i) - (prefix[mid] - prefix[i])
            right = (prefix[j + 1] - prefix[mid + 1]) - ones[mid] * (j - mid)
            total = left + right
            res = min(res, total)

        return res