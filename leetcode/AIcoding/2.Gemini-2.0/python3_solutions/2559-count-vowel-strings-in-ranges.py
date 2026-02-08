class Solution:
    def vowelStrings(self, words: list[str], queries: list[list[int]]) -> list[int]:
        vowels = "aeiou"
        prefix_sums = [0] * (len(words) + 1)
        for i, word in enumerate(words):
            prefix_sums[i + 1] = prefix_sums[i] + (word[0] in vowels and word[-1] in vowels)

        result = []
        for start, end in queries:
            result.append(prefix_sums[end + 1] - prefix_sums[start])
        return result