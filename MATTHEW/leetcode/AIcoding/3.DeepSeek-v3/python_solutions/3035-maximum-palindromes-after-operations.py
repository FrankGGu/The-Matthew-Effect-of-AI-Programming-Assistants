from collections import defaultdict

class Solution:
    def maxPalindromesAfterOperations(self, words: List[str]) -> int:
        freq = defaultdict(int)
        pairs = 0
        for word in words:
            for c in word:
                freq[c] += 1
                if freq[c] % 2 == 0:
                    pairs += 1

        words.sort(key=lambda x: len(x))
        res = 0
        for word in words:
            needed_pairs = len(word) // 2
            if pairs >= needed_pairs:
                pairs -= needed_pairs
                res += 1
            else:
                break
        return res