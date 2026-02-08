class Solution:
    def countVowelSubstrings(self, word: str) -> int:
        n = len(word)
        count = 0
        vowels = {'a', 'e', 'i', 'o', 'u'}

        for i in range(n):
            current_vowel_counts = {'a': 0, 'e': 0, 'i': 0, 'o': 0, 'u': 0}

            for j in range(i, n):
                char = word[j]

                if char not in vowels:
                    break

                current_vowel_counts[char] += 1

                if (current_vowel_counts['a'] > 0 and
                    current_vowel_counts['e'] > 0 and
                    current_vowel_counts['i'] > 0 and
                    current_vowel_counts['o'] > 0 and
                    current_vowel_counts['u'] > 0):
                    count += 1

        return count