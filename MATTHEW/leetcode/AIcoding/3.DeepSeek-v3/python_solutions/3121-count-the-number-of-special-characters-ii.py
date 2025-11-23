class Solution:
    def numberOfSpecialChars(self, word: str) -> int:
        lower = [False] * 26
        upper = [False] * 26
        special = [False] * 26

        for c in word:
            if c.islower():
                lower[ord(c) - ord('a')] = True
            else:
                upper[ord(c) - ord('A')] = True

        for i in range(26):
            if lower[i] and upper[i]:
                special[i] = True

        return sum(special)