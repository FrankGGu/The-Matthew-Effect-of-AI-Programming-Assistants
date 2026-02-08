class Solution:
    def countVowels(self, word: str) -> int:
        n = len(word)
        vowels = "aeiou"
        count = 0
        for i in range(n):
            if word[i] in vowels:
                count += (i + 1) * (n - i)
        return count