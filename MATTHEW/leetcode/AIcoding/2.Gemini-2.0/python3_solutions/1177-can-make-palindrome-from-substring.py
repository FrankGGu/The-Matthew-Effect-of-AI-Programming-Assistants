class Solution:
    def canMakePaliQueries(self, s: str, queries: List[List[int]]) -> List[bool]:
        n = len(s)
        prefix = [[0] * 26 for _ in range(n + 1)]
        for i in range(n):
            for j in range(26):
                prefix[i + 1][j] = prefix[i][j]
            prefix[i + 1][ord(s[i]) - ord('a')] += 1

        result = []
        for left, right, k in queries:
            odd_count = 0
            for i in range(26):
                if (prefix[right + 1][i] - prefix[left][i]) % 2 != 0:
                    odd_count += 1

            result.append(odd_count // 2 <= k)

        return result