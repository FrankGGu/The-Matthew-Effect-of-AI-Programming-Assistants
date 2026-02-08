class CombinationIterator:

    def __init__(self, characters: str, combinationLength: int):
        self.combinations = []
        self.index = 0
        self._backtrack(characters, combinationLength, "", 0)

    def _backtrack(self, chars, length, current, start):
        if len(current) == length:
            self.combinations.append(current)
            return
        for i in range(start, len(chars)):
            self._backtrack(chars, length, current + chars[i], i + 1)

    def next(self) -> str:
        result = self.combinations[self.index]
        self.index += 1
        return result

    def hasNext(self) -> bool:
        return self.index < len(self.combinations)