class Solution:
    def beautifulSubstrings(self, s: str, k: int) -> int:
        count = 0
        vowels = set(['a', 'e', 'i', 'o', 'u'])
        for i in range(len(s)):
            vowel_count = 0
            for j in range(i, len(s)):
                if s[j] in vowels:
                    vowel_count += 1
                consonant_count = (j - i + 1) - vowel_count
                if vowel_count == consonant_count and (vowel_count * consonant_count) % k == 0:
                    count += 1
        return count