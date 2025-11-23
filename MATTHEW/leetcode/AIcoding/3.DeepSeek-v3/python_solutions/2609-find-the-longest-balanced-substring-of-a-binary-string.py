class Solution:
    def findTheLongestBalancedSubstring(self, s: str) -> int:
        max_len = 0
        n = len(s)
        for i in range(n):
            zeros = 0
            ones = 0
            if s[i] == '0':
                zeros += 1
                for j in range(i + 1, n):
                    if s[j] == '0':
                        zeros += 1
                    else:
                        ones += 1
                        if zeros == ones:
                            max_len = max(max_len, zeros + ones)
                    if ones > zeros:
                        break
        return max_len