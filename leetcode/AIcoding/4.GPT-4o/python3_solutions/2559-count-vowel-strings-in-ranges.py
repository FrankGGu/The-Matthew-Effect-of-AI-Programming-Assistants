class Solution:
    def vowelStrings(self, words: List[str], queries: List[List[int]]) -> List[int]:
        vowels = set('aeiou')
        prefix_sum = [0] * (len(words) + 1)

        for i in range(1, len(words) + 1):
            prefix_sum[i] = prefix_sum[i - 1] + (1 if words[i - 1][0] in vowels and words[i - 1][-1] in vowels else 0)

        result = []
        for start, end in queries:
            result.append(prefix_sum[end + 1] - prefix_sum[start])

        return result