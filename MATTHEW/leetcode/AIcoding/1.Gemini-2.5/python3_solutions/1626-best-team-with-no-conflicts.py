class Solution:
    def bestTeamWithNoConflicts(self, scores: list[int], ages: list[int]) -> int:
        n = len(scores)

        players = []
        for i in range(n):
            players.append((ages[i], scores[i]))

        players.sort()

        dp = [0] * n

        for i in range(n):
            dp[i] = players[i][1]

        max_total_score = 0
        if n > 0:
            max_total_score = max(dp)

        for i in range(n):
            current_score = players[i][1]
            for j in range(i):
                if players[j][1] <= current_score:
                    dp[i] = max(dp[i], current_score + dp[j])

            max_total_score = max(max_total_score, dp[i])

        return max_total_score