class Solution:
    def numberOfWays(self, k: int, questions: list[list[int]]) -> int:
        n = len(questions)
        dp = {}

        def solve(i, remaining):
            if i == n:
                return 1 if remaining == 0 else 0

            if (i, remaining) in dp:
                return dp[(i, remaining)]

            ways = 0
            points, free = questions[i]

            if remaining >= points:
                ways += solve(i + 1, remaining - points)
            ways += solve(i + 1, remaining + free)

            dp[(i, remaining)] = ways
            return ways

        return solve(0, k)