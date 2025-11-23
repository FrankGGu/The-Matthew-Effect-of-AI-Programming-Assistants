class Solution:
    def countVowelSubstrings(self, word: str) -> int:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        n = len(word)
        count = 0
        for i in range(n):
            for j in range(i + 1, n + 1):
                substring = word[i:j]
                if set(substring) == vowels:
                    count += 1
        return count