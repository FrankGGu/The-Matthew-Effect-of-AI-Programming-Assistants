class Solution:
    def minMoves(self, nums: List[int], k: int) -> int:
        ones_indices = [i for i, num in enumerate(nums) if num == 1]
        n = len(ones_indices)
        if k > n or k <= 0:
            return 0

        prefix_sum = [0] * (n + 1)
        for i in range(1, n + 1):
            prefix_sum[i] = prefix_sum[i - 1] + ones_indices[i - 1]

        mid = k // 2
        ans = float('inf')
        for i in range(mid, n - (k - 1 - mid)):
            left = i - mid
            right = i + (k - 1 - mid)

            median_index = ones_indices[i]

            left_sum = prefix_sum[i + 1] - prefix_sum[left]
            right_sum = prefix_sum[right + 1] - prefix_sum[i + 1]

            moves = (median_index * (i - left) - (left_sum - prefix_sum[left])) + \
                    ((right_sum - prefix_sum[i + 1]) - median_index * (right - i))

            moves -= (k // 2) * (k // 2 + 1) // 2
            moves -= ((k - 1 - k // 2) * (k - k // 2)) // 2

            ans = min(ans, moves)

        return ans