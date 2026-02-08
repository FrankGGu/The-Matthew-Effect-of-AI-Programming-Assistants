class Solution:
    def appendCharacters(self, s: str, t: str) -> int:
        i = 0  # Pointer for s
        j = 0  # Pointer for t

        while i < len(s) and j < len(t):
            if s[i] == t[j]:
                i += 1
            j += 1

        return len(s) - i