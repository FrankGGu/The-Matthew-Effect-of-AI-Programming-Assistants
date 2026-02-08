class Solution:
    def findMostFrequentVowelAndConsonant(self, s: str) -> str:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        vowel_counts = {}
        consonant_counts = {}

        for char in s.lower():
            if char.isalpha():
                if char in vowels:
                    vowel_counts[char] = vowel_counts.get(char, 0) + 1
                else:
                    consonant_counts[char] = consonant_counts.get(char, 0) + 1

        max_vowel = ''
        max_vowel_count = 0
        for vowel, count in vowel_counts.items():
            if count > max_vowel_count or (count == max_vowel_count and vowel < max_vowel):
                max_vowel = vowel
                max_vowel_count = count

        max_consonant = ''
        max_consonant_count = 0
        for consonant, count in consonant_counts.items():
            if count > max_consonant_count or (count == max_consonant_count and consonant < max_consonant):
                max_consonant = consonant
                max_consonant_count = count

        if not max_vowel and not max_consonant:
            return ""
        elif not max_vowel:
            return f"consonant {max_consonant}"
        elif not max_consonant:
            return f"vowel {max_vowel}"
        else:
            return f"vowel {max_vowel} consonant {max_consonant}"