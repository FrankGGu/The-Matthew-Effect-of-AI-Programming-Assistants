class Solution:
    def mostFrequentVowelAndConsonant(self, s: str) -> str:
        vowels = set('aeiou')
        count = {}
        for char in s:
            if char in vowels:
                count[char] = count.get(char, 0) + 1
            else:
                count[char] = count.get(char, 0) + 1
        max_vowel = ''
        max_consonant = ''
        max_vowel_count = 0
        max_consonant_count = 0
        for char, freq in count.items():
            if char in vowels:
                if freq > max_vowel_count:
                    max_vowel_count = freq
                    max_vowel = char
            else:
                if freq > max_consonant_count:
                    max_consonant_count = freq
                    max_consonant = char
        return max_vowel + max_consonant