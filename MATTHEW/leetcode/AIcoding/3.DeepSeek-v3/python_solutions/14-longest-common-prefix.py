class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        if not strs:
            return ""
        min_len = min(len(s) for s in strs)
        prefix = []
        for i in range(min_len):
            char = strs[0][i]
            for s in strs:
                if s[i] != char:
                    return ''.join(prefix)
            prefix.append(char)
        return ''.join(prefix)