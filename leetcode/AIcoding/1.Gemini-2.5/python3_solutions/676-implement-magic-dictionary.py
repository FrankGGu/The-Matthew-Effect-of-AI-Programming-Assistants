from collections import defaultdict

class MagicDictionary:

    def __init__(self):
        self.words_by_length = defaultdict(set)

    def buildDict(self, dictionary: list[str]) -> None:
        for word in dictionary:
            self.words_by_length[len(word)].add(word)

    def search(self, searchWord: str) -> bool:
        n = len(searchWord)

        if n not in self.words_by_length:
            return False

        for word in self.words_by_length[n]:
            diff_count = 0
            for i in range(n):
                if word[i] != searchWord[i]:
                    diff_count += 1
                if diff_count > 1:
                    break

            if diff_count == 1:
                return True

        return False