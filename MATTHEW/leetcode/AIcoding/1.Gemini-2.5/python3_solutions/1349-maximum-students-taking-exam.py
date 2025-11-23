class Solution:
    def maxStudents(self, seats: list[list[str]]) -> int:
        m = len(seats)
        n = len(seats[0])

        invalid_seat_masks = [0] * m
        for r in range(m):
            for c in range(n):
                if seats[r][c] == '#':
                    invalid_seat_masks[r] |= (1 << c)

        def count_set_bits(mask):
            count = 0
            while mask > 0:
                mask &= (mask - 1)
                count += 1
            return count

        dp = [[-1] * (1 << n) for _ in range(m)]

        for current_mask in range(1 << n):
            if (current_mask & (current_mask << 1)) == 0:
                if (current_mask & invalid_seat_masks[0]) == 0:
                    dp[0][current_mask] = count_set_bits(current_mask)

        for r in range(1, m):
            for current_mask in range(1 << n):
                if (current_mask & (current_mask << 1)) != 0:
                    continue
                if (current_mask & invalid_seat_masks[r]) != 0:
                    continue

                for prev_mask in range(1 << n):
                    if dp[r-1][prev_mask] == -1:
                        continue

                    if (current_mask & (prev_mask << 1)) != 0:
                        continue
                    if (current_mask & (prev_mask >> 1)) != 0:
                        continue

                    dp[r][current_mask] = max(dp[r][current_mask], dp[r-1][prev_mask] + count_set_bits(current_mask))

        max_students = 0
        for mask in range(1 << n):
            max_students = max(max_students, dp[m-1][mask])

        return max_students