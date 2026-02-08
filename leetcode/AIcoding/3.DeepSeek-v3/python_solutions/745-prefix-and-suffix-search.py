class WordFilter:

    def __init__(self, words: List[str]):
        self.prefix_suffix_map = {}
        for weight, word in enumerate(words):
            n = len(word)
            for i in range(n + 1):
                for j in range(n + 1):
                    prefix = word[:i]
                    suffix = word[j:]
                    key = (prefix, suffix)
                    self.prefix_suffix_map[key] = weight

    def f(self, prefix: str, suffix: str) -> int:
        key = (prefix, suffix)
        return self.prefix_suffix_map.get(key, -1)