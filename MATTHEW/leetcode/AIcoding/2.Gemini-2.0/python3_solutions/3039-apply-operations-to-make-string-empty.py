class Solution:
    def makeStringEmpty(self, s: str) -> str:
        n = len(s)
        last = {}
        for i in range(n):
            last[s[i]] = i

        res = ""
        seen = set()

        for i in range(n):
            if s[i] not in seen:
                res += s[i]
                seen.add(s[i])

        return "".join(sorted(res))