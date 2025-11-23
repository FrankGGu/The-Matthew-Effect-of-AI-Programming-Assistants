class Solution:
    def solve(self, n: int, m: int, projects: list[list[list[int]]]) -> int:
        dp = [0] * (m + 1)

        for project_choices in projects:
            for j in range(m, -1, -1):
                for volunteers_needed, profit in project_choices:
                    if j >= volunteers_needed:
                        dp[j] = max(dp[j], dp[j - volunteers_needed] + profit)

        return max(dp)