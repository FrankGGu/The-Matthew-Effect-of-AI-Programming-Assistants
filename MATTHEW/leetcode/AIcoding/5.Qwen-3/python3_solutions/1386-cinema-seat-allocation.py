class Solution:
    def maxStudents(self, seats: List[List[int]]) -> int:
        from collections import deque

        m, n = len(seats), len(seats[0])
        row_masks = [0] * m

        for i in range(m):
            for j in range(n):
                if seats[i][j] == 1:
                    row_masks[i] |= (1 << j)

        def is_valid(mask):
            return (mask & (mask << 1)) == 0

        def count_ones(mask):
            return bin(mask).count('1')

        dp = [0] * (1 << n)
        for i in range(m):
            curr_dp = [0] * (1 << n)
            for mask in range(1 << n):
                if (mask & row_masks[i]) != mask:
                    continue
                if not is_valid(mask):
                    continue
                for prev_mask in range(1 << n):
                    if (prev_mask & mask) == 0:
                        curr_dp[mask] = max(curr_dp[mask], dp[prev_mask] + count_ones(mask))
            dp = curr_dp

        return max(dp)