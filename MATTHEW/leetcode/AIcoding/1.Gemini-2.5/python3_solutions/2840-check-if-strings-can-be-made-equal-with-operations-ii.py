from collections import Counter

class Solution:
    def checkStrings(self, s1: str, s2: str) -> bool:
        n = len(s1)

        s1_even_chars = []
        s1_odd_chars = []
        s2_even_chars = []
        s2_odd_chars = []

        for i in range(n):
            if i % 2 == 0:
                s1_even_chars.append(s1[i])
                s2_even_chars.append(s2[i])
            else:
                s1_odd_chars.append(s1[i])
                s2_odd_chars.append(s2[i])

        if Counter(s1_even_chars) != Counter(s2_even_chars):
            return False

        if Counter(s1_odd_chars) != Counter(s2_odd_chars):
            return False

        return True