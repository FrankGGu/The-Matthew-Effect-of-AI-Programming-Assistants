from collections import Counter

class Solution:
    def minSteps(self, s: str, t: str) -> int:
        s_count = Counter(s)
        t_count = Counter(t)

        steps = 0
        for char, count in t_count.items():
            if char not in s_count:
                steps += count
            elif s_count[char] < count:
                steps += count - s_count[char]

        return steps