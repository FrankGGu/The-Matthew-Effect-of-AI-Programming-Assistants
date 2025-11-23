class Solution:
    def getWordsInLongestSubsequence(self, n: int, words: List[str], groups: List[int]) -> List[str]:
        dp = [1] * n
        prev = [-1] * n
        max_len = 1
        max_idx = 0

        for i in range(1, n):
            for j in range(i):
                if groups[i] != groups[j] and len(words[i]) == len(words[j]):
                    mismatch = 0
                    for a, b in zip(words[i], words[j]):
                        if a != b:
                            mismatch += 1
                            if mismatch > 1:
                                break
                    if mismatch == 1:
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