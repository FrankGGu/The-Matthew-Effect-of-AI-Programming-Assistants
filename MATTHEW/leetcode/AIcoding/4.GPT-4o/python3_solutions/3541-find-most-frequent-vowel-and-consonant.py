class Solution:
    def mostFrequent(self, s: str) -> List[str]:
        from collections import Counter

        vowels = set('aeiou')
        s = s.lower()
        counter = Counter(c for c in s if c.isalpha())

        most_freq_vowel = max((c for c in counter if c in vowels), key=lambda x: (counter[x], x), default='')
        most_freq_consonant = max((c for c in counter if c not in vowels), key=lambda x: (counter[x], x), default='')

        return [most_freq_vowel, most_freq_consonant]