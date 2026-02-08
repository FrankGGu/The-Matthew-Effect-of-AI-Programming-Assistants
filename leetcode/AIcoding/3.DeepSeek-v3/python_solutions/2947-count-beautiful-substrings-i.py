class Solution:
    def beautifulSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        count = 0
        vowels = {'a', 'e', 'i', 'o', 'u'}

        for i in range(n):
            vowels_count = 0
            consonants_count = 0
            for j in range(i, n):
                if s[j] in vowels:
                    vowels_count += 1
                else:
                    consonants_count += 1

                if vowels_count == consonants_count and (vowels_count * consonants_count) % k == 0:
                    count += 1

        return count