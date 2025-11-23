class Solution:
    def countAlmostEqualPairs(self, s1: str, s2: str, k: int) -> int:
        n = len(s1)
        count = 0
        for i in range(n):
            for j in range(i + 1, n):
                if abs(i - j) <= k:
                    if s1[i] == s2[j] and s1[j] == s2[i]:
                        count += 1
        return count