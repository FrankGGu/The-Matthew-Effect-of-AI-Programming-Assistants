class Solution:
    def countOfSubstrings(self, s: str, k: int) -> int:
        from collections import defaultdict

        vowels = {'a', 'e', 'i', 'o', 'u'}
        n = len(s)
        count = 0
        left = 0
        vowel_count = defaultdict(int)
        consonant_count = 0

        for right in range(n):
            if s[right] in vowels:
                vowel_count[s[right]] += 1
            else:
                consonant_count += 1

            while consonant_count > k:
                if s[left] in vowels:
                    vowel_count[s[left]] -= 1
                    if vowel_count[s[left]] == 0:
                        del vowel_count[s[left]]
                else:
                    consonant_count -= 1
                left += 1

            if consonant_count == k and len(vowel_count) == 5:
                count += 1

        return count