class Solution:
    def halvesAreAlike(self, s: str) -> bool:
        vowels = "aeiouAEIOU"
        n = len(s)
        a_vowels = 0
        b_vowels = 0
        for i in range(n // 2):
            if s[i] in vowels:
                a_vowels += 1
        for i in range(n // 2, n):
            if s[i] in vowels:
                b_vowels += 1
        return a_vowels == b_vowels