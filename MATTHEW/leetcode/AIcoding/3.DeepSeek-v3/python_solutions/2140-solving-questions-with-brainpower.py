class Solution:
    def mostPoints(self, questions: List[List[int]]) -> int:
        n = len(questions)
        dp = [0] * (n + 1)

        for i in range(n - 1, -1, -1):
            points, brainpower = questions[i]
            next_question = i + brainpower + 1
            if next_question < n:
                dp[i] = max(dp[i + 1], points + dp[next_question])
            else:
                dp[i] = max(dp[i + 1], points)

        return dp[0]