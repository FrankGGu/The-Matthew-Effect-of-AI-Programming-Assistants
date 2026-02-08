class Solution:
    def totalCharacters(self, words: List[str], chars: str) -> int:
        from collections import defaultdict

        def count_chars(s):
            freq = defaultdict(int)
            for c in s:
                freq[c] += 1
            return freq

        chars_freq = count_chars(chars)
        res = 0

        for word in words:
            word_freq = count_chars(word)
            valid = True
            for c in word_freq:
                if word_freq[c] > chars_freq.get(c, 0):
                    valid = False
                    break
            if valid:
                res += len(word)

        return res