class Solution:
    def vowelStrings(self, words: list[str], queries: list[list[int]]) -> list[int]:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        n = len(words)
        prefix_sum = [0] * (n + 1)

        for i in range(n):
            word = words[i]
            is_vowel_string = 0
            if word[0] in vowels and word[-1] in vowels:
                is_vowel_string = 1
            prefix_sum[i + 1] = prefix_sum[i] + is_vowel_string

        results = []
        for li, ri in queries:
            count = prefix_sum[ri + 1] - prefix_sum[li]
            results.append(count)

        return results