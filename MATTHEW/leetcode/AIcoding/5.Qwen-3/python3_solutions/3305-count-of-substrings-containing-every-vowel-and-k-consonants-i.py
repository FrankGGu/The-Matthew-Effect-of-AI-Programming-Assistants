class Solution:
    def countOfSubstrings(self, word: str, k: int) -> int:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        n = len(word)
        result = 0

        for i in range(n):
            vowel_count = {v: 0 for v in vowels}
            consonant_count = 0
            for j in range(i, n):
                c = word[j]
                if c in vowels:
                    vowel_count[c] += 1
                else:
                    consonant_count += 1
                if consonant_count == k and all(vowel_count[v] > 0 for v in vowels):
                    result += 1
        return result