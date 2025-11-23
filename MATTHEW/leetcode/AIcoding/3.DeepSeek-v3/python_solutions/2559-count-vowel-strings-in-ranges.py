class Solution:
    def vowelStrings(self, words: List[str], queries: List[List[int]]) -> List[int]:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        prefix = [0] * (len(words) + 1)
        for i in range(len(words)):
            word = words[i]
            if word[0] in vowels and word[-1] in vowels:
                prefix[i+1] = prefix[i] + 1
            else:
                prefix[i+1] = prefix[i]
        res = []
        for l, r in queries:
            res.append(prefix[r+1] - prefix[l])
        return res