import collections

class Solution:
    def findMostFrequentVowelAndConsonant(self, s: str) -> list[str]:
        vowels = {'a', 'e', 'i', 'o', 'u'}

        vowel_counts = collections.Counter()
        consonant_counts = collections.Counter()

        for char in s:
            if char in vowels:
                vowel_counts[char] += 1
            else:
                consonant_counts[char] += 1

        most_frequent_vowel = ""
        if vowel_counts:
            max_vowel_freq = 0
            for freq in vowel_counts.values():
                if freq > max_vowel_freq:
                    max_vowel_freq = freq

            candidate_vowels = []
            for char, freq in vowel_counts.items():
                if freq == max_vowel_freq:
                    candidate_vowels.append(char)

            candidate_vowels.sort()
            most_frequent_vowel = candidate_vowels[0]

        most_frequent_consonant = ""
        if consonant_counts:
            max_consonant_freq = 0
            for freq in consonant_counts.values():
                if freq > max_consonant_freq:
                    max_consonant_freq = freq

            candidate_consonants = []
            for char, freq in consonant_counts.items():
                if freq == max_consonant_freq:
                    candidate_consonants.append(char)

            candidate_consonants.sort()
            most_frequent_consonant = candidate_consonants[0]

        return [most_frequent_vowel, most_frequent_consonant]