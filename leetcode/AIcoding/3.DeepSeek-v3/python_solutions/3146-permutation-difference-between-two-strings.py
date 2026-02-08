class Solution:
    def findPermutationDifference(self, s: str, t: str) -> int:
        pos_s = {char: idx for idx, char in enumerate(s)}
        pos_t = {char: idx for idx, char in enumerate(t)}
        difference = 0
        for char in s:
            difference += abs(pos_s[char] - pos_t[char])
        return difference