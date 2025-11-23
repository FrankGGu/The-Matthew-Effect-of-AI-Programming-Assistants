class Solution:
    def canMakePalindromeQueries(self, s: str, queries: List[List[int]]) -> List[bool]:
        n = len(s)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + (s[i] != s[n - 1 - i])

        res = []
        for l, r in queries:
            total = prefix[r + 1] - prefix[l]
            if total == 0:
                res.append(True)
            else:
                res.append(False)
        return res