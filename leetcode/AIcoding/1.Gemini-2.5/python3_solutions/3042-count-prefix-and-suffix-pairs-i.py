class Solution:
    def countPrefixSuffixPairs(self, words: list[str]) -> int:
        n = len(words)
        count = 0
        for i in range(n):
            for j in range(i + 1, n):
                if words[j].startswith(words[i]) and words[j].endswith(words[i]):
                    count += 1
        return count