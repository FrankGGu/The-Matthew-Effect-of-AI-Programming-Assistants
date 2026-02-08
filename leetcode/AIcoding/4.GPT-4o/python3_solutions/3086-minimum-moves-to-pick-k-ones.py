class Solution:
    def minMoves(self, nums: List[int], k: int) -> int:
        ones = [i for i, num in enumerate(nums) if num == 1]
        m = len(ones)
        prefix_sum = [0] * (m + 1)

        for i in range(m):
            prefix_sum[i + 1] = prefix_sum[i] + ones[i]

        min_moves = float('inf')

        for i in range(k, m + 1):
            mid = (i - k) // 2
            left = prefix_sum[mid + 1]
            right = prefix_sum[i] - prefix_sum[mid + 1]
            moves = right - left - (k - 1) * ones[mid]
            min_moves = min(min_moves, moves)

        return min_moves