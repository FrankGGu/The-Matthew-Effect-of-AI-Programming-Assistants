class Solution:
    def countSubstrings(self, s: str, t: str) -> int:
        def count_diff(s, t):
            return sum(1 for a, b in zip(s, t) if a != b)

        result = 0
        for i in range(len(s)):
            for j in range(len(t)):
                diff = count_diff(s[i:], t[j:])
                if diff == 1:
                    result += 1
                elif diff == 0:
                    result += len(t) - j
        return result