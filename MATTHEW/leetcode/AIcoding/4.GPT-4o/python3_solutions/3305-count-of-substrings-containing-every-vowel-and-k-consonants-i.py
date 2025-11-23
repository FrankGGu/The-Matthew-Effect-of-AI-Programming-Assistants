class Solution:
    def countVowelSubstrings(self, s: str, k: int) -> int:
        vowels = set("aeiou")
        n = len(s)
        count = 0

        for i in range(n):
            if s[i] not in vowels:
                continue

            vowel_count = {v: 0 for v in vowels}
            consonant_count = 0

            for j in range(i, n):
                if s[j] in vowels:
                    vowel_count[s[j]] += 1
                else:
                    consonant_count += 1

                if all(vowel_count[v] > 0 for v in vowels) and consonant_count == k:
                    count += 1

        return count