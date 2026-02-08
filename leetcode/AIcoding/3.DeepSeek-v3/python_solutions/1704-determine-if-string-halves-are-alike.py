class Solution:
    def halvesAreAlike(self, s: str) -> bool:
        vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}
        half = len(s) // 2
        a = s[:half]
        b = s[half:]
        count_a = sum(1 for c in a if c in vowels)
        count_b = sum(1 for c in b if c in vowels)
        return count_a == count_b