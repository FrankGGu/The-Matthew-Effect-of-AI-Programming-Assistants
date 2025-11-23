class Solution:
    def largeGroupPositions(self, s: str) -> list[list[int]]:
        result = []
        n = len(s)
        if n == 0:
            return result

        start = 0
        for i in range(n + 1):
            if i == n or s[i] != s[start]:
                if i - start >= 3:
                    result.append([start, i - 1])
                start = i

        return result