class Solution:
    def prefixSuffixMatch(self, words: List[str]) -> int:
        from collections import defaultdict

        count = 0
        prefix_count = defaultdict(int)
        suffix_count = defaultdict(int)

        for word in words:
            n = len(word)
            for i in range(n):
                prefix = word[:i+1]
                suffix = word[n-i-1:]
                prefix_count[prefix] += 1
                suffix_count[suffix] += 1

        for word in words:
            n = len(word)
            for i in range(n):
                prefix = word[:i+1]
                suffix = word[n-i-1:]
                if prefix == suffix:
                    count += prefix_count[prefix] * suffix_count[suffix]

        return count