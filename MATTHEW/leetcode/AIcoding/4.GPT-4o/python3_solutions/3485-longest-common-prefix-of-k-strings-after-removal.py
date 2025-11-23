class Solution:
    def longestCommonPrefix(self, strs: List[str], k: int) -> str:
        from collections import Counter

        if k > len(strs):
            return ""

        prefix = ""
        for i in range(min(len(s) for s in strs)):
            char_count = Counter(s[i] for s in strs)
            if len(char_count) == 1:
                prefix += char_count.most_common(1)[0][0]
            elif len(char_count) > k:
                break

        return prefix