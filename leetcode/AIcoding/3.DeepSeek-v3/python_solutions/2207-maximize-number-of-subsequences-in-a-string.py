class Solution:
    def maximumSubsequenceCount(self, text: str, pattern: str) -> int:
        a, b = pattern[0], pattern[1]
        if a == b:
            count = text.count(a)
            return count * (count + 1) // 2
        count_a = 0
        res = 0
        for c in text:
            if c == a:
                count_a += 1
            elif c == b:
                res += count_a
        return res + max(text.count(a), text.count(b))