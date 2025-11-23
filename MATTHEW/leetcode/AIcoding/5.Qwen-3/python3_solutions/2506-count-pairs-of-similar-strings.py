class Solution:
    def similarPairs(self, words: List[str]) -> int:
        from collections import defaultdict

        count = 0
        freq = defaultdict(int)

        for word in words:
            key = tuple(sorted(set(word)))
            count += freq[key]
            freq[key] += 1

        return count