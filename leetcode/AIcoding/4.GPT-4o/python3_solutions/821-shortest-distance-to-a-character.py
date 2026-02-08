class Solution:
    def shortestToChar(self, s: str, c: str) -> List[int]:
        result = []
        prev = float('-inf')

        for i in range(len(s)):
            if s[i] == c:
                prev = i
            result.append(i - prev)

        prev = float('inf')

        for i in range(len(s) - 1, -1, -1):
            if s[i] == c:
                prev = i
            result[i] = min(result[i], prev - i)

        return result