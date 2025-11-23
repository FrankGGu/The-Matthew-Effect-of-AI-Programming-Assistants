class Solution:
    def canMakePaliQueries(self, s: str, queries: List[List[int]]) -> List[bool]:
        n = len(s)
        prefix = [ [0] * 26 for _ in range(n + 1) ]
        for i in range(n):
            for j in range(26):
                prefix[i+1][j] = prefix[i][j]
            c = ord(s[i]) - ord('a')
            prefix[i+1][c] += 1

        res = []
        for left, right, k in queries:
            odd = 0
            for j in range(26):
                cnt = prefix[right+1][j] - prefix[left][j]
                if cnt % 2 == 1:
                    odd += 1
            res.append(odd // 2 <= k)
        return res