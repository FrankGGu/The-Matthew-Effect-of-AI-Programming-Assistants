class Solution:
    def orderlyQueue(self, s: str, k: int) -> str:
        if k > 1:
            return "".join(sorted(list(s)))
        else:
            res = s
            for i in range(1, len(s)):
                temp = s[i:] + s[:i]
                if temp < res:
                    res = temp
            return res