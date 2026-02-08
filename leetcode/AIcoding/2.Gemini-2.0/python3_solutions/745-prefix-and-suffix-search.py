class WordFilter:

    def __init__(self, words: list[str]):
        self.word_dict = {}
        for i, word in enumerate(words):
            n = len(word)
            for j in range(n + 1):
                prefix = word[:j]
                for k in range(n + 1):
                    suffix = word[n-k:]
                    self.word_dict[(prefix, suffix)] = i

    def f(self, pref: str, suff: str) -> int:
        if (pref, suff) in self.word_dict:
            return self.word_dict[(pref, suff)]
        else:
            return -1