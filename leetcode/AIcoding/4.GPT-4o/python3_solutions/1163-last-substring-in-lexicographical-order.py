class Solution:
    def lastSubstring(self, s: str) -> str:
        max_char = max(s)
        idx = len(s) - 1
        result = []

        for i in range(len(s) - 1, -1, -1):
            if s[i] == max_char:
                result.append(s[i])
            elif result:
                break

        return ''.join(reversed(result))