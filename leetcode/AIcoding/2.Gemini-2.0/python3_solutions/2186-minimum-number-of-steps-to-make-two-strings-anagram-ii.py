from collections import Counter

class Solution:
    def minSteps(self, s: str, t: str) -> int:
        s_count = Counter(s)
        t_count = Counter(t)

        steps = 0
        for char in s_count:
            if char in t_count:
                steps += abs(s_count[char] - t_count[char])
            else:
                steps += s_count[char]

        for char in t_count:
            if char not in s_count:
                steps += t_count[char]

        return steps // 2 if steps % 2 == 0 else steps