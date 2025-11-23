class Solution:
    def equalSumGridPartition(self, grid: list[list[int]]) -> bool:
        M = len(grid)
        if M == 0:
            return False
        N = len(grid[0])
        if N == 0:
            return False

        if M < 2 or N < 2:
            return False

        ps = [[0] * (N + 1) for _ in range(M + 1)]
        for r in range(M):
            for c in range(N):
                ps[r + 1][c + 1] = grid[r][c] + ps[r][c + 1] + ps[r + 1][c] - ps[r][c]

        def get_sum(r1, c1, r2, c2):
            if r1 > r2 or c1 > c2:
                return 0
            return ps[r2 + 1][c2 + 1] - ps[r1][c2 + 1] - ps[r2 + 1][c1] + ps[r1][c1]

        for r_cut in range(1, M):
            for c_cut in range(1, N):
                s1 = get_sum(0, 0, r_cut - 1, c_cut - 1)
                s2 = get_sum(0, c_cut, r_cut - 1, N - 1)
                s3 = get_sum(r_cut, 0, M - 1, c_cut - 1)
                s4 = get_sum(r_cut, c_cut, M - 1, N - 1)

                if s1 == s2 and s1 == s3 and s1 == s4:
                    return True

        return False