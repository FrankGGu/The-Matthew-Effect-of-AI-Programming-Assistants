class Solution:
    def isValid(self, word: str) -> bool:
        if len(word) < 3:
            return False
        vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}
        has_vowel = False
        has_consonant = False
        valid_chars = set('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')

        for c in word:
            if c not in valid_chars:
                return False
            if c in vowels:
                has_vowel = True
            elif c.isalpha():
                has_consonant = True

        return has_vowel and has_consonant