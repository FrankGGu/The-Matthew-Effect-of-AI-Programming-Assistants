class Solution:
    def findSubstringInWraproundString(self, p: str) -> int:
        if not p:
            return 0

        dp = [0] * 26
        current_max_len = 0

        for i in range(len(p)):
            if i > 0 and (ord(p[i]) - ord(p[i-1]) == 1 or \
                          (p[i-1] == 'z' and p[i] == 'a')):
                current_max_len += 1
            else:
                current_max_len = 1

            char_idx = ord(p[i]) - ord('a')
            dp[char_idx] = max(dp[char_idx], current_max_len)

        return sum(dp)