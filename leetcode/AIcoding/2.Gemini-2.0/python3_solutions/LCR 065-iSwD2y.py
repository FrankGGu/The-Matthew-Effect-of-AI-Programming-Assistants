class Solution:
    def minimumLengthEncoding(self, words: list[str]) -> int:
        words = sorted(list(set(words)), key=len, reverse=True)
        good = []
        for word in words:
            is_good = True
            for w in good:
                if w.endswith(word):
                    is_good = False
                    break
            if is_good:
                good.append(word)
        return sum(len(word) + 1 for word in good)