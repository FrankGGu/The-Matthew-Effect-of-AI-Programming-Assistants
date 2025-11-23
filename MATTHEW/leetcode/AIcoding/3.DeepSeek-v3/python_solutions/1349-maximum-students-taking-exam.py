class Solution:
    def maxStudents(self, seats: List[List[str]]) -> int:
        m, n = len(seats), len(seats[0])
        dp = [[-1] * (1 << n) for _ in range(m + 1)]
        dp[0][0] = 0

        valid_seats = [0] * m
        for i in range(m):
            mask = 0
            for j in range(n):
                if seats[i][j] == '.':
                    mask |= 1 << j
            valid_seats[i] = mask

        for i in range(1, m + 1):
            current_mask = valid_seats[i - 1]
            for prev_state in range(1 << n):
                if dp[i - 1][prev_state] == -1:
                    continue
                for current_state in range(1 << n):
                    if (current_state & current_mask) != current_state:
                        continue
                    if (current_state & (current_state >> 1)):
                        continue
                    if (current_state & (prev_state >> 1)) or ((current_state >> 1) & prev_state):
                        continue
                    dp[i][current_state] = max(dp[i][current_state], dp[i - 1][prev_state] + bin(current_state).count('1'))

        return max(dp[m])