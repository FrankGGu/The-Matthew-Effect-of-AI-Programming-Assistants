class MagicDictionary:

    def __init__(self):
        self.words = set()

    def buildDict(self, dictionary: list[str]) -> None:
        self.words = set(dictionary)

    def search(self, searchWord: str) -> bool:
        for word in self.words:
            if len(word) == len(searchWord):
                diff = 0
                for i in range(len(word)):
                    if word[i] != searchWord[i]:
                        diff += 1
                if diff == 1:
                    return True
        return False