class Solution:
    def countCharacters(self, words: List[str], chars: str) -> int:
        from collections import defaultdict

        def get_counts(s):
            counts = defaultdict(int)
            for c in s:
                counts[c] += 1
            return counts

        chars_count = get_counts(chars)
        total = 0

        for word in words:
            word_count = get_counts(word)
            valid = True
            for c in word_count:
                if word_count[c] > chars_count.get(c, 0):
                    valid = False
                    break
            if valid:
                total += len(word)

        return total