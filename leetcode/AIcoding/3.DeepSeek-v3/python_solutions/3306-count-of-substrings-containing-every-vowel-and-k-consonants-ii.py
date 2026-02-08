class Solution:
    def countSubstrings(self, s: str, k: int) -> int:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        n = len(s)
        res = 0

        for i in range(n):
            vowel_set = set()
            consonant_count = 0
            for j in range(i, n):
                char = s[j]
                if char in vowels:
                    vowel_set.add(char)
                else:
                    consonant_count += 1

                if len(vowel_set) == 5 and consonant_count == k:
                    res += 1

        return res