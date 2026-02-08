class Solution:
    def maxStudents(self, seats: List[List[str]]) -> int:
        m, n = len(seats), len(seats[0])
        dp = [0] * (1 << n)

        for i in range(m):
            new_dp = dp[:]
            for mask in range(1 << n):
                if dp[mask] == 0 and i > 0:
                    continue
                for new_mask in range(1 << n):
                    if self.valid(seats[i], new_mask) and (new_mask & mask) == 0:
                        new_dp[new_mask] = max(new_dp[new_mask], dp[mask] + bin(new_mask).count('1'))
            dp = new_dp

        return max(dp)

    def valid(self, row: List[str], mask: int) -> bool:
        for j in range(len(row)):
            if (mask & (1 << j)) != 0:
                if row[j] == '#':
                    return False
                if j > 0 and (mask & (1 << (j - 1))) != 0:
                    return False
                if j < len(row) - 1 and (mask & (1 << (j + 1))) != 0:
                    return False
        return True