class Solution:
    def longestCommonPrefix(self, k, strings):
        if not strings:
            return ""
        min_len = min(len(s) for s in strings)
        prefix = ""
        for i in range(min_len):
            char = strings[0][i]
            for j in range(1, k):
                if strings[j][i] != char:
                    return prefix
            prefix += char
        return prefix