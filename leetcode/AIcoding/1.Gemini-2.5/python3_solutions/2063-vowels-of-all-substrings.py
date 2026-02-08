class Solution:
    def countVowels(self, word: str) -> int:
        n = len(word)
        total_vowels = 0
        vowels = {'a', 'e', 'i', 'o', 'u'}

        for i in range(n):
            if word[i] in vowels:
                total_vowels += (i + 1) * (n - i)

        return total_vowels