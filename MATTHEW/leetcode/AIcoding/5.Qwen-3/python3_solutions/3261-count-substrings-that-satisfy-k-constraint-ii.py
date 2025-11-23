class Solution:
    def countSubstrings(self, s: str, k: int) -> int:
        from collections import defaultdict

        def is_valid(freq):
            return any(count >= k for count in freq.values())

        n = len(s)
        result = 0

        for i in range(n):
            freq = defaultdict(int)
            for j in range(i, n):
                freq[s[j]] += 1
                if is_valid(freq):
                    result += 1

        return result