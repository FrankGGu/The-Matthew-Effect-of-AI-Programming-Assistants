class Solution:
    def findTheString(self, lcp: List[List[int]]) -> str:
        n = len(lcp)
        res = ['a'] * n
        for i in range(n):
            for j in range(i + 1, n):
                if lcp[i][j] > 0:
                    res[j] = res[i]

        for i in range(n):
            for j in range(n):
                length = 0
                if res[i] == res[j]:
                    k = 0
                    while i + k < n and j + k < n and res[i+k] == res[j+k]:
                        length += 1
                        k += 1
                if length != lcp[i][j]:
                    return ""

        count = 0
        chars = set()
        for char in res:
            chars.add(char)

        if len(chars) > 26:
            return ""

        return "".join(res)