class Solution:
    def getLongestSubsequence(self, groups: list[list[str | int]]) -> list[int]:
        n = len(groups)
        if n == 0:
            return []

        dp = [1] * n
        prev_idx = [-1] * n

        for i in range(n):
            for j in range(i):
                # Check if groups[j] and groups[i] are unequal
                # They are unequal if their string names are different OR their integer values are different
                if groups[j][0] != groups[i][0] or groups[j][1] != groups[i][1]:
                    if dp[j] + 1 > dp[i]:
                        dp[i] = dp[j] + 1
                        prev_idx[i] = j

        max_len = 0
        last_idx = -1
        for i in range(n):
            if dp[i] > max_len:
                max_len = dp[i]
                last_idx = i

        result = []
        current_idx = last_idx
        while current_idx != -1:
            result.append(current_idx)
            current_idx = prev_idx[current_idx]

        return result[::-1]