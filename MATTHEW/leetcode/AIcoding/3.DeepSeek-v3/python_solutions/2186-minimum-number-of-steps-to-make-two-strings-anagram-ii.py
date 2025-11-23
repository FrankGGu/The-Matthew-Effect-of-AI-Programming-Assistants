class Solution:
    def minSteps(self, s: str, t: str) -> int:
        from collections import defaultdict

        count_s = defaultdict(int)
        count_t = defaultdict(int)

        for char in s:
            count_s[char] += 1

        for char in t:
            count_t[char] += 1

        all_chars = set(count_s.keys()).union(set(count_t.keys()))
        steps = 0

        for char in all_chars:
            steps += abs(count_s[char] - count_t[char])

        return steps