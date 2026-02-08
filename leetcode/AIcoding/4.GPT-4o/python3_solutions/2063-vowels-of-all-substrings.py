class Solution:
    def countVowels(self, word: str) -> int:
        vowels = set('aeiou')
        n = len(word)
        total_vowels = 0

        for i in range(n):
            if word[i] in vowels:
                total_vowels += (i + 1) * (n - i)

        return total_vowels