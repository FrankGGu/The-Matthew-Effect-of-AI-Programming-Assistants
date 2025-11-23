class Solution:
    def longestUnequalAdjacentGroupsSubsequence(self, words: list[str], groups: list[int]) -> list[str]:
        n = len(words)
        dp = [0] * n
        prev = [-1] * n
        max_len = 0
        max_idx = -1

        for i in range(n):
            dp[i] = 1
            for j in range(i):
                if groups[i] != groups[j] and self.hamming_distance(words[i], words[j]) == 1:
                    if dp[j] + 1 > dp[i]:
                        dp[i] = dp[j] + 1
                        prev[i] = j
            if dp[i] > max_len:
                max_len = dp[i]
                max_idx = i

        res = []
        while max_idx != -1:
            res.append(words[max_idx])
            max_idx = prev[max_idx]

        return res[::-1]

    def hamming_distance(self, s1: str, s2: str) -> int:
        if len(s1) != len(s2):
            return float('inf')
        dist = 0
        for i in range(len(s1)):
            if s1[i] != s2[i]:
                dist += 1
        return dist