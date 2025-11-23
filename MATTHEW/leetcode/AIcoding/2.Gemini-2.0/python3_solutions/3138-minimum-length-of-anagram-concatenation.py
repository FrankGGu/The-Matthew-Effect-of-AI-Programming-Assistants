from collections import Counter

class Solution:
    def minAnagramLength(self, s: str, p: str) -> int:
        n, m = len(s), len(p)
        p_count = Counter(p)
        ans = float('inf')

        for i in range(n - m + 1):
            sub = s[i:i+m]
            sub_count = Counter(sub)
            if sub_count == p_count:
                ans = min(ans, m)

        if ans == float('inf'):
            return -1

        return ans