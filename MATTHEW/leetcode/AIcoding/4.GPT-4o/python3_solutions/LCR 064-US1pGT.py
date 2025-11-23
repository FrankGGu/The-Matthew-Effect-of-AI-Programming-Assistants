class MagicDictionary:

    def __init__(self):
        self.words = set()

    def buildDict(self, dictionary: List[str]) -> None:
        self.words = set(dictionary)

    def search(self, searchWord: str) -> bool:
        for word in self.words:
            if len(word) == len(searchWord):
                diff = sum(1 for a, b in zip(word, searchWord) if a != b)
                if diff == 1:
                    return True
        return False