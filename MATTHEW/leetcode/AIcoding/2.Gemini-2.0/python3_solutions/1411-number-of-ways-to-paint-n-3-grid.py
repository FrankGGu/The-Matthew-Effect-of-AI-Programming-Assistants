class Solution:
    def numOfWays(self, n: int) -> int:
        MOD = 10**9 + 7

        def get_valid_colors():
            colors = []
            for c1 in range(1, 4):
                for c2 in range(1, 4):
                    if c1 != c2:
                        for c3 in range(1, 4):
                            if c2 != c3:
                                colors.append((c1, c2, c3))
            return colors

        valid_colors = get_valid_colors()

        dp = {}

        def solve(row, prev_colors):
            if row == n:
                return 1

            if (row, prev_colors) in dp:
                return dp[(row, prev_colors)]

            count = 0
            for colors in valid_colors:
                valid = True
                if row > 0:
                    for i in range(3):
                        if colors[i] == prev_colors[i]:
                            valid = False
                            break

                if valid:
                    count = (count + solve(row + 1, colors)) % MOD

            dp[(row, prev_colors)] = count
            return count

        return solve(0, (0, 0, 0))