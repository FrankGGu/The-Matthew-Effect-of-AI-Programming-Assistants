class Solution:
    def divideString(self, s: str, k: int, fill: str) -> list[str]:
        res = []
        for i in range(0, len(s), k):
            sub = s[i:i+k]
            if len(sub) < k:
                sub += fill * (k - len(sub))
            res.append(sub)
        return res