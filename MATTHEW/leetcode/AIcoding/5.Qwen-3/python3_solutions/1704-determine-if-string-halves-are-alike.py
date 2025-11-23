class Solution:
    def halvesAreAlike(self, s: str) -> bool:
        vowels = set('aeiouAEIOU')
        n = len(s)
        a = s[:n//2]
        b = s[n//2:]
        count_a = sum(1 for c in a if c in vowels)
        count_b = sum(1 for c in b if c in vowels)
        return count_a == count_b