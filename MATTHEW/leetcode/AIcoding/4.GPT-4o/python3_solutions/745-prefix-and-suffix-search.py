class WordFilter:

    def __init__(self, words: List[str]):
        self.words = words
        self.prefix_map = {}
        for weight, word in enumerate(words):
            for i in range(len(word) + 1):
                for j in range(len(word) + 1):
                    prefix = word[:i]
                    suffix = word[j:]
                    self.prefix_map[(prefix, suffix)] = weight

    def f(self, prefix: str, suffix: str) -> int:
        return self.prefix_map.get((prefix, suffix), -1)