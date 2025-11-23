class Solution:
    def findSubstringInWraproundString(self, p: str) -> int:
        max_len = [0] * 26
        cur_len = 0

        for i in range(len(p)):
            if i > 0 and (ord(p[i]) - ord(p[i - 1]) + 26) % 26 == 1:
                cur_len += 1
            else:
                cur_len = 1
            max_len[ord(p[i]) - ord('a')] = max(max_len[ord(p[i]) - ord('a')], cur_len)

        return sum(max_len)