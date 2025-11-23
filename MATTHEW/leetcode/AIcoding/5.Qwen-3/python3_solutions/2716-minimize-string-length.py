class Solution:
    def minimizeConcatenatedLength(self, word1: str, word2: str) -> int:
        from collections import defaultdict

        def merge(a, b):
            return a + b

        def get_min_length(s1, s2):
            count = defaultdict(int)
            for c in s1:
                count[c] += 1
            for c in s2:
                count[c] += 1
            return len(count)

        return get_min_length(word1, word2)