class Solution:
    def maximumSubsequenceCount(self, text: str, pattern: str) -> int:
        a = pattern[0]
        b = pattern[1]
        cnt_a = 0
        cnt_b = 0
        res = 0
        for c in text:
            if c == b:
                res += cnt_a
                cnt_b += 1
            if c == a:
                cnt_a += 1
        return res + max(cnt_a, cnt_b)