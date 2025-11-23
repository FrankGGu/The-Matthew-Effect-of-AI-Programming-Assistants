class Solution:
    def countVowelSubstrings(self, s: str, k: int) -> int:
        vowels = set('aeiou')
        n = len(s)
        count = 0

        for start in range(n):
            vowel_count = {v: 0 for v in vowels}
            consonant_count = 0

            for end in range(start, n):
                if s[end] in vowels:
                    vowel_count[s[end]] += 1
                else:
                    consonant_count += 1

                if all(vowel_count[v] > 0 for v in vowels) and consonant_count >= k:
                    count += 1

        return count