from collections import defaultdict

class MagicDictionary:

    def __init__(self):
        self.words_by_len = defaultdict(list)

    def buildDict(self, dictionary: list[str]) -> None:
        for word in dictionary:
            self.words_by_len[len(word)].append(word)

    def search(self, searchWord: str) -> bool:
        search_len = len(searchWord)

        if search_len not in self.words_by_len:
            return False

        for word in self.words_by_len[search_len]:
            diff_count = 0
            for i in range(search_len):
                if word[i] != searchWord[i]:
                    diff_count += 1
                if diff_count > 1:
                    break

            if diff_count == 1:
                return True

        return False