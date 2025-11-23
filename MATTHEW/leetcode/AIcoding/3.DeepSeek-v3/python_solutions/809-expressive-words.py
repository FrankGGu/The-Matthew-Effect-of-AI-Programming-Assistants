class Solution:
    def expressiveWords(self, S: str, words: List[str]) -> int:
        def RLE(s):
            return zip(*[(k, len(list(g))) for k, g in itertools.groupby(s)])

        if not S:
            return 0

        S_chars, S_counts = RLE(S)
        res = 0

        for word in words:
            if not word:
                continue
            word_chars, word_counts = RLE(word)
            if S_chars != word_chars:
                continue
            valid = True
            for sc, wc in zip(S_counts, word_counts):
                if sc < wc or (sc < 3 and sc != wc):
                    valid = False
                    break
            if valid:
                res += 1

        return res