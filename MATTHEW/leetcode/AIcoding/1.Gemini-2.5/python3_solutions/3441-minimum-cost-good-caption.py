import collections

class Solution:
    def minimumCost(self, targetCaption: str, captionOptions: list[list[str]]) -> int:
        N = len(targetCaption)
        M = len(captionOptions)

        words = [option[0] for option in captionOptions]
        costs = [option[1] for option in captionOptions]

        adj_matrix = [[False] * M for _ in range(M)]
        for j in range(M):
            for k in range(M):
                if words[j].startswith(words[k]) or words[k].startswith(words[j]):
                    adj_matrix[j][k] = True

        dp = [[float('inf')] * M for _ in range(N + 1)]

        for i in range(1, N + 1):
            for j in range(M):
                word_j = words[j]
                cost_j = costs[j]
                len_j = len(word_j)

                if i >= len_j and targetCaption[i - len_j:i] == word_j:
                    if i - len_j == 0:
                        dp[i][j] = min(dp[i][j], cost_j)

                    for k in range(M):
                        if adj_matrix[k][j]:
                            if dp[i - len_j][k] != float('inf'):
                                dp[i][j] = min(dp[i][j], dp[i - len_j][k] + cost_j)

        min_total_cost = float('inf')
        for j in range(M):
            min_total_cost = min(min_total_cost, dp[N][j])

        return min_total_cost if min_total_cost != float('inf') else -1