from typing import List

class Solution:
    def mostPoints(self, questions: List[List[int]]) -> int:
        n = len(questions)
        dp = [0] * (n + 1)

        for i in range(n - 1, -1, -1):
            points_i, brainpower_i = questions[i]

            skip_points = dp[i + 1]

            solve_points = points_i
            next_question_idx = i + brainpower_i + 1
            if next_question_idx < n:
                solve_points += dp[next_question_idx]

            dp[i] = max(skip_points, solve_points)

        return dp[0]