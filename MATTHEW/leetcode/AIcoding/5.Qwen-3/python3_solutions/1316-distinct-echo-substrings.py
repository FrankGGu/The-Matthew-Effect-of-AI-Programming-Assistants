class Solution:
    def echoSubstrings(self, s: str) -> int:
        n = len(s)
        result = set()

        for i in range(n):
            for j in range(i + 1, n):
                length = j - i
                if j + length <= n and s[i:j] == s[j:j+length]:
                    result.add(s[i:j])

        return len(result)