class Solution:
    def minSteps(self, s: str, t: str) -> int:
        from collections import defaultdict

        count_s = defaultdict(int)
        count_t = defaultdict(int)

        for char in s:
            count_s[char] += 1

        for char in t:
            count_t[char] += 1

        steps = 0

        for char in count_s:
            if count_s[char] > count_t[char]:
                steps += count_s[char] - count_t[char]

        return steps