from collections import Counter

class Solution:
    def minSteps(self, s: str, t: str) -> int:
        count_s = Counter(s)
        count_t = Counter(t)

        steps = 0
        for char_code in range(ord('a'), ord('z') + 1):
            char = chr(char_code)

            if count_t[char] > count_s[char]:
                steps += (count_t[char] - count_s[char])

        return steps