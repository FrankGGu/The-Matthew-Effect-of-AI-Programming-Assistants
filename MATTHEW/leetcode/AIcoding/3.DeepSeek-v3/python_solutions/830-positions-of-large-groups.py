class Solution:
    def largeGroupPositions(self, s: str) -> List[List[int]]:
        result = []
        n = len(s)
        if n == 0:
            return result
        start = 0
        for i in range(1, n):
            if s[i] != s[start]:
                if i - start >= 3:
                    result.append([start, i - 1])
                start = i
        if n - start >= 3:
            result.append([start, n - 1])
        return result