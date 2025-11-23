from collections import Counter

class Solution:
    def minPermutationDifference(self, s: str, t: str) -> int:
        n = len(s)
        s_counts = Counter(s)
        t_counts = Counter(t)

        diff = 0
        for char in s_counts:
            diff += abs(s_counts[char] - t_counts[char])

        for char in t_counts:
            if char not in s_counts:
                diff += t_counts[char]

        return diff // 2