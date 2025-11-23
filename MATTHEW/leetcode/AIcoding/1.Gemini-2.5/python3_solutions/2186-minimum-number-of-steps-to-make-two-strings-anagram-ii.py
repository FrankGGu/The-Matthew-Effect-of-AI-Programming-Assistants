import collections

class Solution:
    def minSteps(self, s: str, t: str) -> int:
        count_s = collections.Counter(s)
        count_t = collections.Counter(t)

        steps = 0

        for char_code in range(ord('a'), ord('z') + 1):
            char = chr(char_code)

            freq_s = count_s[char]
            freq_t = count_t[char]

            steps += abs(freq_s - freq_t)

        return steps